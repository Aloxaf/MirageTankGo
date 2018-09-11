extern crate image;

use image::*;
use image::Rgba;

pub struct MirageTank {
    wimg: DynamicImage,
    bimg: DynamicImage,
    width: u32,
    height: u32,
}

impl MirageTank {

    // TODO: 统一图片大小
    pub fn open(wimg: &str, bimg: &str) -> Result<MirageTank, ImageError> {
        let _wimg = image::open(wimg)?;
        let _bimg = image::open(bimg)?;

        let (wwidth, wheight) = _wimg.dimensions();
        let (bwidth, bheight) = _bimg.dimensions();

        let width = std::cmp::max(wwidth, bwidth);
        let height = std::cmp::max(wheight, bheight);

        let mut wimg = DynamicImage::new_rgba8(width, height);
        let mut bimg = DynamicImage::new_rgba8(width, height);

        wimg.copy_from(&_wimg, (width - wwidth) / 2, (height - wheight) / 2);
        bimg.copy_from(&_bimg, (width - bwidth) / 2, (height - bheight) / 2);

        Ok(MirageTank {
            wimg,
            bimg,
            width,
            height
        })
    }

    fn greyize(&self, rgba1: Rgba<u8>, rgba2: Rgba<u8>, wlight: f32, blight: f32) -> Rgba<u8>  {
        let c1 = f32::from(rgba1.to_luma().data[0]) / 255.0 * wlight;
        let c2 = f32::from(rgba2.to_luma().data[0]) / 255.0 * blight;

        let a = (1.0 - c1 + c2).min(1.0);
        let r = (c2 / a).min(1.0);

        let a = (a * 255.0).round() as u8;
        let r = (r * 255.0).round() as u8;

        Rgba { data: [r, r, r, a] }
    }

    fn colorize(&self, rgba1: Rgba<u8>, rgba2: Rgba<u8>, wlight: f32, blight: f32, wcolor: f32, bcolor: f32) -> Rgba<u8> {
        // turn 0~255 to 0~1 and change light
        let rgb1 = rgba1.to_rgb().data.iter().map(|&c| {
            (f32::from(c) / 255.0 * wlight).min(1.0)
        }).collect::<Vec<_>>();
        let rgb2 = rgba2.to_rgb().data.iter().map(|&c| {
            (f32::from(c) / 255.0 * blight).min(1.0)
        }).collect::<Vec<_>>();

        let gray1 = rgb1.iter().fold(0.0, |s, c| s + c / 3.0).min(1.0);
        let gray2 = rgb2.iter().fold(0.0, |s, c| s + c / 3.0).min(1.0);

        let rgb1 = rgb1.iter().map(|c| c * wcolor + gray1 * (1.0 - wcolor)).collect::<Vec<_>>();
        let rgb2 = rgb2.iter().map(|c| c * bcolor + gray2 * (1.0 - bcolor)).collect::<Vec<_>>();

        let drgb = rgb1.iter().zip(rgb2.iter()).map(|(c1, c2)| 1.0 - c1 + c2).collect::<Vec<_>>();

        let maxc = rgb2[0].max(rgb2[1]).max(rgb2[2]);

        let a = (drgb[0] * 0.222 + drgb[1] * 0.707 + drgb[2] * 0.071).max(maxc).min(1.0);

        let r = ((rgb2[0] / a).min(1.0) * 255.0).round() as u8;
        let g = ((rgb2[1] / a).min(1.0) * 255.0).round() as u8;
        let b = ((rgb2[2] / a).min(1.0) * 255.0).round() as u8;

        Rgba { data: [r, g, b, (a * 255.0).round() as u8] }
    }

    pub fn checkerboarding(&mut self) {
        for w in 0..self.width {
            for h in 0..self.height {
                if (w + h) % 2 == 0 {
                    self.bimg.put_pixel(w, h, Rgba { data: [255, 255, 255, 255] });
                } else {
                    self.wimg.put_pixel(w, h, Rgba { data: [0, 0, 0, 0] });
                }
            }
        }
    }

    pub fn greycarize(&mut self, wlight: f32, blight: f32) -> DynamicImage {
        let mut outimg = DynamicImage::new_rgba8(self.width, self.height);

        for w in 0..self.width {
            for h in 0..self.height {
                let c = self.greyize(self.wimg.get_pixel(w, h),
                                     self.bimg.get_pixel(w, h),
                                     wlight,
                                     blight);
                outimg.put_pixel(w, h, c);
            }
        }

        outimg
    }

    pub fn colorcarize(&self, wlight: f32, blight: f32, wcolor: f32, bcolor: f32) -> DynamicImage {
        let mut outimg = DynamicImage::new_rgba8(self.width, self.height);

        for w in 0..self.width {
            for h in 0..self.height {
                let c = self.colorize(self.wimg.get_pixel(w, h),
                                      self.bimg.get_pixel(w, h),
                                      wlight, blight, wcolor, bcolor);
                outimg.put_pixel(w, h, c);
            }
        }

        outimg
    }
}


/*#[cfg(test)]
mod tests {

    use super::greycarize;
    use super::colorcarize;
    use image::Rgba;

    #[test]
    fn grey() {
        let c1 = Rgba { data: [0xde, 0xad, 0xbe, 0xef] };
        let c2 = Rgba { data: [0xba, 0xaa, 0xaa, 0xad] };
        // TODO: 这玩意儿咋测试....
        greycarize(c1, c2, 1.0, 0.2);
    }

    #[test]
    fn color() {
        let c1 = Rgba { data: [0xde, 0xad, 0xbe, 0xef] };
        let c2 = Rgba { data: [0xba, 0xaa, 0xaa, 0xad] };
        colorcarize(c1, c2, 1.0, 0.2, 0.5, 0.7);
    }
}*/
