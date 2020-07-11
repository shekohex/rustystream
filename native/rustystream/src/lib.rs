#![deny(unsafe_code)]

use futures::{channel::mpsc, executor::block_on, Stream};
use serde::Serialize;
use std::thread;

#[derive(Debug, Ord, PartialOrd, Eq, PartialEq, Serialize)]
pub enum Event {
    Ping(),
    Update(String),
    UpdateProgress(u64),
}

pub fn events(n: u64) -> impl Stream<Item = Event> {
    let (mut tx, rx) = mpsc::channel(n as usize);
    let t = async move {
        use Event::*;
        for i in 0..n {
            match i {
                _ if i % 2 == 0 => tx.try_send(Ping()).expect("send error"),
                x if i % 3 == 0 => tx.try_send(Update(x.to_string())).expect("send error"),
                p => tx.try_send(UpdateProgress(p)).expect("send error"),
            }
        }
    };
    thread::spawn(|| {
        block_on(t);
    });
    rx
}
