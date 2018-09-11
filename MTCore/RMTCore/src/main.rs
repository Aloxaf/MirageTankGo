#[macro_use]
extern crate serde_derive;
extern crate docopt;
extern crate mirage_tank;

use std::process;
use mirage_tank::MirageTank;
use docopt::Docopt;

const USAGE: &str = "
幻影坦克快速发车工具

Usage:
    mirage_tank -h
    mirage_tank -o <output> <whiteimg> <blackimg> [-s] [-c] [--wscale=<wscale>] [--bscale=<bscale>] [--wlight=<wlight] [--blight=blight>] [--wcolor=<wcolor>] [--bcolor=<bcolor>]
    mirage_tank -v

Arguments:
    output             输出文件, PNG格式
    blackimg           黑底下显示的图片
    whiteimg           白底下显示的图片

Options:
    -h, --help           显示本帮助
    -o, --output         输出文件(png格式)
    -s, --sparse         使用棋盘格
    -c, --color          发彩色车
    --wscale=<wscale>    白底图像缩放比例 [default: 1.0]
    --bscale=<bscale>    黑底图像缩放比例 [default: 1.0]
    --wlight=<wlight>    白底图像的亮度, 取值 0~1 [default: 1.0]
    --blight=<blight>    黑底图像的亮度, 取值 0~1 [default: 0.2]
    --wcolor=<wcolor>    彩色车的白底色彩保留比例, 取值 0~1 [default: 0.5]
    --bcolor=<bcolor>    彩色车的黑底色彩保留比例, 取值 0~1 [default: 0.7]
    -v, --version        显示版本号

Examples:
    mirage_tank -o remu.png black.jpg white.jpg
";

#[derive(Debug, Deserialize)]
struct Args {
    flag_s: bool,
    flag_c: bool,
    flag_wscale: f32,
    flag_bscale: f32,
    flag_wlight: f32,
    flag_blight: f32,
    flag_wcolor: f32,
    flag_bcolor: f32,
    arg_output: String,
    arg_blackimg: String,
    arg_whiteimg: String,
}

fn main() {
    let args: Args = Docopt::new(USAGE)
        .and_then(|d| d.deserialize())
        .unwrap_or_else(|e| e.exit());

    // println!("{:?}", args);

    let mut tank = MirageTank::open(&args.arg_whiteimg,
                                    &args.arg_blackimg,
                                    args.flag_wscale,
                                    args.flag_bscale).unwrap_or_else( |e| {
        eprintln!("fail to load file: {}", e);
        process::exit(1);
    });

    if args.flag_s {
        tank.checkerboarding();
    }

    let output = if args.flag_c {
        tank.colorcarize(args.flag_wlight, args.flag_blight, args.flag_wcolor, args.flag_bcolor)
    } else {
        tank.greycarize(args.flag_wlight, args.flag_blight)
    };

    if args.arg_output == "-" {
        unimplemented!();
    } else {
        output.save(args.arg_output).unwrap_or_else(|e| {
            eprintln!("fail to save file: {}", e);
            process::exit(1);
        });
    }

}
