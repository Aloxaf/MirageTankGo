extern crate image;
extern crate mirage_tank;

#[cfg(test)]
mod tests {
    use mirage_tank::MirageTank;

    #[test]
    fn test_grey() {
        let whiteimg_name = "./white.jpg";
        let blackimg_name = "./black.jpg";
        let finalimg_name = "./final_grey.png";

        let mut tank = MirageTank::open(whiteimg_name, blackimg_name).unwrap();

        tank.greycarize(1.0, 0.2).save(finalimg_name).unwrap();
    }

    #[test]
    fn test_color() {
        let whiteimg_name = "./white.jpg";
        let blackimg_name = "./black.jpg";
        let finalimg_name = "./final_color.png";

        let mut tank = MirageTank::open(whiteimg_name, blackimg_name).unwrap();

        tank.colorcarize(1.0, 0.18, 0.5, 0.7).save(finalimg_name).unwrap();
    }
}