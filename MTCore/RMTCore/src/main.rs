#[macro_use]
extern crate clap;

extern crate mirage_tank;

use clap::App;
use mirage_tank::MirageTank;
use std::process;
use std::path::PathBuf;


fn main() {
    let yaml = load_yaml!("../cli.yml");
    let matches = App::from_yaml(yaml).get_matches();
    // println!("{:?}", matches);

    let wimage = matches.value_of("wimage").unwrap();
    let bimage = matches.value_of("bimage").unwrap();

    let wscale = value_t!(matches.value_of("wscale"), f32).unwrap_or(1.0);
    let bscale = value_t!(matches.value_of("bscale"), f32).unwrap_or(1.0);

    let mut output = PathBuf::from(matches.value_of("output").unwrap_or("output.png"));
    output.set_extension("png");

    if output.exists() && matches.occurrences_of("force") == 0 {
        eprintln!("can't write to {}: file already exists!", output.to_str().unwrap());
        process::exit(1);
    }

    let mut car = MirageTank::open(wimage, bimage, wscale, bscale).unwrap_or_else(|e| {
        eprintln!("fail to load file: {}", e);
        process::exit(1);
    });

    let wlight = value_t!(matches.value_of("wlight"), f32).unwrap_or(1.0);
    let blight = value_t!(matches.value_of("blight"), f32).unwrap_or(0.2);

    if matches.occurrences_of("sparse") == 1 {
        car.checkerboarding();
    }

    let oimage = if matches.occurrences_of("colorful") == 0 {
        car.greycarize(wlight, blight)
    } else {
        let wcolor = value_t!(matches.value_of("wcolor"), f32).unwrap_or(0.5);
        let bcolor = value_t!(matches.value_of("bcolor"), f32).unwrap_or(0.7);
        car.colorcarize(wlight, blight, wcolor, bcolor)
    };

    oimage.save(output.to_str().unwrap()).unwrap_or_else(|e| {
        eprintln!("can't write to {}: {}", output.to_str().unwrap(), e);
    });
}