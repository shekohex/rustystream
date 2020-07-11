#![deny(unsafe_code)]

use allo_isolate::Isolate;
use async_std::task;
use futures::StreamExt;
use rustystream::events;
use std::sync::atomic::{AtomicBool, Ordering};

static SUBSCRIBED: AtomicBool = AtomicBool::new(false);

#[no_mangle]
pub extern "C" fn stream_subscribe(port: i64, n: u64) -> i32 {
    let mut stream = events(n);
    let isolate = Isolate::new(port);
    let t = async move {
        loop {
            let subscribed = SUBSCRIBED.load(Ordering::Relaxed);
            if !subscribed {
                break;
            }
            if let Some(event) = stream.next().await {
                isolate.post(serde_json::to_string(&event));
            } else {
                let null: Option<String> = None;
                isolate.post(null);
                break;
            }
        }
    };
    SUBSCRIBED.store(true, Ordering::Relaxed);
    task::spawn(t);
    1
}

#[no_mangle]
pub extern "C" fn stream_unsubscribe() -> i32 {
    SUBSCRIBED.store(false, Ordering::Relaxed);
    1
}
