extern crate image;
extern crate mirage_tank;



#[cfg(test)]
mod tests {
    use mirage_tank::MirageTank;
    use std::time::SystemTime;

    #[test]
    fn test_grey() {
        let time = SystemTime::now();
        let whiteimg_name = "./white.jpg";
        let blackimg_name = "./black.jpg";
        let finalimg_name = "./final_grey.png";

        let mut tank = MirageTank::open(whiteimg_name, blackimg_name, 1.0, 1.0).unwrap();
        println!("load: {:?}", time.elapsed());
        tank.greycarize(1.0, 0.2).save(finalimg_name).unwrap();

        println!("greycarize: {:?}", time.elapsed());
    }

    #[test]
    fn test_color() {
        let whiteimg_name = "./white.jpg";
        let blackimg_name = "./black.jpg";
        let finalimg_name = "./final_color.png";

        let mut tank = MirageTank::open(whiteimg_name, blackimg_name, 1.0, 1.0).unwrap();

        tank.colorcarize(1.0, 0.18, 0.5, 0.7).save(finalimg_name).unwrap();
    }

}