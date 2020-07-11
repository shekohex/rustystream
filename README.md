<h1 align="center">Rusty Stream</h1>
<div align="center">
  <strong>
        A simple demo of how to use Rust streams/channels with Dart
  </strong>

</div>

<br />

## Try it!

1. Clone

```bash
git clone https://github.com/shekohex/rustystream.git
```

2. Install Cargo Make (skip if you have it already)

```
cargo install --force cargo-make
```

3. Build it

```
cargo make
```

4. Run

```
dart ./bin/rustystream.dart
```

## Safety

This crate uses `#![deny(unsafe_code)]` to ensure everything is implemented in
100% Safe Rust.

## License

<sup>
Licensed under <a href="LICENSE">Apache v2.0 license</a>.
</sup>

<br/>

<sub>
Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in this crate by you, as defined in the Apache-2.0 license, shall
be licensed as above, without any additional terms or conditions.
</sub>
