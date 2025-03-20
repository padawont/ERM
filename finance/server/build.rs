use std::env;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let out_dir = env::var("OUT_DIR").expect("OUT_DIR is not defined");  // Debugging step
    println!("cargo:warning=OUT_DIR is: {}", out_dir); // Print it to see if it's available

    tonic_build::compile_protos("../proto/voting.proto")?;
    Ok(())
}
