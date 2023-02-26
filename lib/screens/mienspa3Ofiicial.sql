-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th2 18, 2023 lúc 12:35 PM
-- Phiên bản máy phục vụ: 10.4.25-MariaDB
-- Phiên bản PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `mienspa3`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `cate_id` int(11) NOT NULL,
  `cate_name` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `cate_id_parent` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`cate_id`, `cate_name`, `cate_id_parent`, `created_at`, `updated_at`, `isDelete`) VALUES
(1, 'Tẩy trang', 0, '2023-02-16 10:59:03', NULL, 0),
(2, 'Sửa rửa mặt', 0, '2023-02-16 10:00:00', NULL, 0),
(3, 'Tẩy tế bào chết', 0, '2023-01-16 10:59:22', NULL, 0),
(4, 'Mặt nạ', 0, '2023-02-16 10:59:57', NULL, 0),
(5, 'Serum', 0, '2023-02-16 11:00:08', NULL, 0),
(6, 'Kem dưỡng ẩm', 0, '2023-02-16 11:00:18', NULL, 0),
(7, 'Nước hoa hồng', 0, '2023-02-16 11:00:32', NULL, 0),
(8, 'Toner', 0, '2023-02-16 11:01:40', NULL, 0),
(9, 'Kem chống nắng', 0, '2023-02-16 11:02:21', NULL, 0),
(10, 'Kem dưỡng mắt', 0, '2023-02-16 11:02:30', NULL, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderserdetail`
--

CREATE TABLE `orderserdetail` (
  `ordSer_Id` int(11) NOT NULL,
  `ordSer_OrderId` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `ordSer_ServiceId` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderspro`
--

CREATE TABLE `orderspro` (
  `orPro_id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_UserId` varchar(128) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orPro_UserName` text COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Dob` varchar(20) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orPro_Address` varchar(150) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orPro_PhoneNo` varchar(15) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Pay_Status` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Payment` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Status` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Note` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orPro_Total` int(20) NOT NULL,
  `orPro_Ship` int(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ordersprodetail`
--

CREATE TABLE `ordersprodetail` (
  `ordPro_Id` int(11) NOT NULL,
  `ordPro_OrderId` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `ordPro_ProductId` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `orPro_Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ordersser`
--

CREATE TABLE `ordersser` (
  `orSer_id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `orSer_UserId` varchar(128) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orSer_PhoneNo` varchar(15) COLLATE utf8_vietnamese_ci NOT NULL,
  `orSer_Status` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `orSer_Note` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orSer_StartTime` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orSer_EndTime` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `orSer_Total` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `pro_id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `pro_name` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `pro_price` int(11) NOT NULL,
  `feature_img_path` varchar(255) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `pro_content` text COLLATE utf8_vietnamese_ci NOT NULL,
  `pro_brand` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `pro_turn_on` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`pro_id`, `pro_name`, `pro_price`, `feature_img_path`, `pro_content`, `pro_brand`, `category_id`, `pro_turn_on`, `created_at`, `updated_at`, `isDelete`) VALUES
('P172230001', 'Bông Tẩy Trang Ipek', 28000, 'P172230001/bongtaytrang_ipek.jpg', 'Bông Tẩy Trang Ipek Klasik Cotton Pads là sản phẩm bông tẩy trang hữu cơ thuộc thương hiệu bông tẩy trang hàng đầu Châu Âu IPEK KLASIK xuất xứ Thổ Nhĩ Kỳ. Được làm từ 100% bông tự nhiên mềm mại với làn da, Ipek Cotton Pads dễ dàng sử dụng vào nhiều mục đích khác nhau như tẩy trang, lau mặt, thoa nước hoa hồng, lotion mask... giúp nàng vừa lấy sạch bụi bẩn vừa dưỡng da hiệu quả. Xuất Xứ : Thổ Nhĩ Kỳ', 'IPek', 1, 0, '2023-02-17 13:25:35', '2023-02-17 13:25:35', 0),
('P172230002', 'Bông tẩy trang Simple', 25000, 'P172230002/bongtaytrang_simple.jpg', 'Bông tẩy trang được ép miếng định hình, có ô dập nổi khối hình hạt massage tăng tính ma sát giúp các nàng lấy đi lớp tẩy trang nhanh, loại bỏ bụi bẩn trong lỗ chân lông, hấm hút dầu thừa trên da hằng ngày. Bông tẩy trang được sản xuất từ 100% bông xơ tự nhiên, không có pha tạp Poly như một số hãng khác đâu nha nên rất nhẹ nhàng kể cả với làn da nhạy cảm, sử dụng công nghệ Spunlace nên bông chắc, mịn, thấm hút tốt, dễ dàng tách lớp. Hướng dẫn sử dụng: Bước 1: thấm nước tẩy trang hoặc nước làm sạch da vào 1 miếng bông sau đó tẩy trang nhẹ nhàng theo 1 hướng rồi quay lại từ đầu, tránh làm rơi miếng bông tẩy trang Bước 2: Dùng nước sạch rửa mặt sau đó dùng sửa rửa mặt tạo bọt và tiến hành massage da mặt trong 3 phút rồi rửa sạch bọt với nước lạnh Bước 3: Dùng bông tẩy trang khô mhẹ nhàng thấm nước trên mặt, sau đó thấm nước hoa hồng hoặc nước  cân bằng da vào miếng bông mới, nhẹ nhàng thoa dung dịch len mặt để cấp ẩm và thu nhỏ lỗ chân lông Thành phần: Bông xơ tự nhiên Xuất Xứ : Anh', 'Simple', 1, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230003', 'Bông Tẩy Trang Silcot', 32000, 'P172230003/bongtaytrang_silcot.jpg', 'Bông tẩy trang Silcot Velvety Touch Cotton là sản phẩm bông tẩy trang bán chạy hàng đầu tại Nhật Bản hơn 10 năm qua đến từ thương hiệu Silcot, được làm từ sợi bông thế hệ mới đảm bảo độ mềm mại, nhẹ dịu cho làn da khi sử dụng. Sản phẩm giúp bạn có được lớp trang điểm tự nhiên hơn, hoặc tẩy trang dễ dàng và nhanh chóng hơn. Xuất xứ : Nhật bản', 'Silcot', 1, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230004', 'BÔNG TẨY TRANG MINISO', 30000, 'P172230004/bongtaytrang_miniso.jpg', '—Thương hiệu: Miniso BÔNG TẨY TRANG MINISO NHẬT BẢN GÓI 180 MIẾNG —100% thành phần bột giấy cotton tự nhiên, mềm mịn —Bông tẩy trang Miniso được làm từ chất liệu Cotton tinh khiết có bề mặt mềm mại, mịn màng, không gây tổn thương, trầy xước khi tiếp xúc với da nhưng vẫn làm sạch bụi bẩn.  —Miếng bông thấm hút dung dịch tốt hơn, làm sạch da hiệu quả hơn, giúp da luôn láng sạch, mịn màng. Dễ sử dụng, khiến cho da mặt bạn thoải mái, dễ chịu.  —Bông mềm và dai, bạn sẽ không lo lắng dính sợi lên mặt như các loại bông tẩy trang khác.  Hướng dẫn sử dụng:  —Thấm dung dịch tẩy trang ra miếng bông rồi lau nhẹ nhàng toàn bộ gương mặt. —Bạn cũng có thể dùng Bông tẩy trang Miniso 180 miếng để làm lotion mask cũng rất hiệu quả. Xuất xứ: Nhật Bản', 'Miniso', 1, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230005', 'Sữa Rửa Mặt Simple', 95000, 'P172230005/bongtaytrang_miniso.jpg', 'Sữa Rửa Mặt Simple Refreshing Facial Wash là sản phẩm sữa rửa mặt dạng gel dành cho mọi loại da nổi tiếng của thương hiệu mỹ phẩm Simple. Với công thức dịu nhẹ không chứa xà phòng cùng thành phần Pro-Vitamin B5 và Vitamin E, sản phẩm giúp làm sạch da hiệu quả, cuốn đi chất nhờn, bụi bẩn và các tạp chất khác mà không gây kích ứng, cho da mềm mịn, đồng thời mang lại cảm giác tươi mát và sạch thoáng cho da. Xuất xứ : Anh', 'Simple', 2, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230006', 'Sữa Rửa Mặt Eucerin', 222000, 'P172230006/bongtaytrang_miniso.jpg', 'Sữa Rửa Mặt Eucerin PH5 Facial Cleanser Sensitive Skin là dòng sữa rửa mặt hoàn toàn mới được Eucerin thiết kế dành riêng cho làn da nhạy cảm, với độ pH5 cân bằng cùng công thức 0% thành phần gây kích ứng da, giúp làm sạch sâu và cải thiện da nhạy cảm. xUẤT XỨ : Đức', 'Eucerin', 2, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230007', 'Gel Rửa Mặt La Roche-Posay', 308000, 'P172230007/gelruamat_la roche-posay.jpg', 'Gel Rửa Mặt La Roche-Posay Effaclar Purifying Foaming Gel For Oily Sensitive Skin là dòng sản phẩm sữa rửa mặt chuyên biệt dành cho làn da dầu, mụn, nhạy cảm đến từ thương hiệu dược mỹ phẩm La Roche-Posay nổi tiếng của Pháp, với kết cấu dạng gel tạo bọt nhẹ nhàng giúp loại bỏ bụi bẩn, tạp chất và bã nhờn dư thừa trên da hiệu quả, mang đến làn da sạch mịn, thoáng nhẹ và tươi mát. Công thức sản phẩm an toàn, lành tính, giảm thiểu tình trạng kích ứng đối với làn da nhạy cảm. Xuất xứ : pháp', 'La Roche-Posay', 2, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P172230008', 'Gel Rửa Mặt Cosrx Tràm Trà', 123000, 'P172230008/gelruamat_la roche-posay.jpg', 'Gel Rửa Mặt Cosrx Tràm Trà, 0.5% BHA Có Độ pH Thấp 150ml là dòng sữa rửa mặt đến từ thương hiệu mỹ phẩm Cosrx của Hàn Quốc, với độ pH lý tưởng 4.5 - 5.5 sản phẩm an toàn và dịu nhẹ trên mọi làn da ngay cả làn da nhạy cảm và da mụn. Gel rửa mặt chứa 0,5% BHA tự nhiên và chiết xuất tràm trà làm sạch sâu lỗ chân lông, hỗ trợ kháng khuẩn, làm sạch mụn đồng thời tẩy da chết nhẹ nhàng. Xuất xứ : Hàn Quốc', 'Cosrx', 2, 1, '2023-02-17 14:18:24', '2023-02-17 14:18:24', 0),
('P182230001', 'Tẩy Tế Bào Chết Da Mặt Cocoon Cà Phê Đắk Lắk', 132000, 'P182230001/taytebaochet_cocoon.jpg', 'Làm Sạch Da Chết Cho Mặt Cocoon Từ Cà Phê Đắk Lắk 150ml là dòng tẩy da chết cho mặt đến từ thương hiệu mỹ phẩm Cocoon của Việt Nam, thành phần từ hạt cà phê Đắk Lắk xay nhuyễn giàu cafeine hòa quyện với bơ cacao Tiền Giang giúp loại bỏ lớp tế bào chết già cỗi và xỉn màu, đánh thức làn da tươi mới, mang lại làn da mịn màng ngay sau lần đầu sử dụng, làn da sáng mịn, đều màu trông thấy. Xuất xứ : Việt Nam ', 'Cocoon', 3, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230002', 'Tẩy Tế Bào Chết Rosette', 99000, 'P182230002/taytebaochet_rosette.jpg', 'Tẩy Tế Bào Chết ROSETTE Gommage Peeling Gel là dòng sản phẩm tẩy tế bào chết đến từ thương hiệu ROSETTE – thương hiệu mỹ phẩm nội địa Nhật Bản được yêu thích và tin dùng. Tại Nhật, dòng Rosette Gommage Peeling Gel đã liên tục nhận giải thưởng Best Award bởi tạp chí làm đẹp uy tín hàng đầu Cosme trong nhiều năm liền, đồng thời nhận được nhiều đánh giá tốt từ các tạp chí nổi tiếng khác trên toàn thế giới. Xuất xứ : Nhật Bản ', 'Rosette', 3, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230003', 'Gel Tẩy Tế Bào Chết La Roche-Posay', 364000, 'P182230003/taytebaochet-la-roche-posay.jpg', 'Trong quy trình chăm sóc da, tẩy tế bào chết cũng là một trong những bước quan trọng và không thể bỏ qua nên bạn muốn sở hữu một làn da đều màu, sáng khỏe. Là sản phẩm thuộc thương hiệu mỹ phẩm nổi tiếng đến từ nước Pháp, Gel Tẩy Tế Bào Chết Cho Da Nhạy Cảm La Roche-Posay Ultra Fine Scrub Sensitive Skin với công thức cân bằng không gây kích ứng da, an toàn cho da nhạy cảm và thành phần không chứa paraben sẽ giúp nhẹ nhàng làm sạch và loại bỏ lớp tế bào chết trên bề mặt da, hỗ trợ làm sạch, cải thiện sắc tố da và giúp mang đến cho bạn một làn da mượt mà và tươi sáng. Xuất xứ : Pháp ', 'La Roche-Posay', 3, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230004', 'Mặt Nạ Nghệ Hưng Yên Cocoon', 130000, 'P182230004/matna_cocoon.jpg', 'Mặt Nạ Nghệ Hưng Yên Cocoon Giúp Da Rạng Rỡ Mịn Màng là dòng mặt nạ rửa đến từ thương hiệu mỹ phẩm thuần chay Cocoon của Việt Nam, với thành phần chính tinh bột nghệ từ củ nghệ ở vùng đất Hưng Yên giàu curcuminoid kết hợp cùng chiết xuất yến mạch, hạt óc chó và vitamin B3 cung cấp dưỡng chất giúp cải thiện bề mặt da sần sùi, thô ráp, lấy đi các tế bào chết nhẹ nhàng mang lại làn da sáng mịn, đều màu, ẩm mượt, rạng ngời. Xuất xứ : Việt Nam ', 'Cocoon', 4, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230005', 'Mặt Nạ BNBG Vitamin B Hỗ Trợ Phục Hồi Da Hư Tổn', 17000, 'P182230005/matna_bnbg_vitaminb.jpg', 'Mặt nạ được xem như vị cứu tinh đối với làn da bạn. BNBG Vita Genic Jelly Mask chứa dưỡng chất Vitamin dạng gel đậm đặc, hàm lượng lên đến 20.000ppm được chiết xuất từ các trái cây tươi ở hòn đảo Jeju xinh đẹp. Mang đến làn da khỏe mạnh, bóng mượt đầy sức sống, phục hồi độ đàn hồi, ngăn ngừa quá trình lão hóa đồng thời cung cấp đủ ẩm cho da luôn mềm, mịn màng. Khi sử dụng BNBG Vita Genic Jelly Mask, bạn sẽ được trải nghiệm cảm giác thư giãn và sảng khoái. BNBG được biết đến là một bệnh viện thẩm mỹ nổi tiếng với đội ngũ bác sĩ có tay nghề hàng đầu tại Hàn Quốc. Là bệnh viện ứng dụng các công nghệ hiện đại tại Châu Á để nghiên cứu ra các loại mỹ phẩm chăm sóc da cũng như các phương pháp phẫu thuật mới để mang lại vẻ đẹp hoàn thiện cho phụ nữ. Chương trình làm đẹp uy tín tại Hàn Quốc Get It Beauty đã đẩy cơn sốt mặt nạ jelly này lên đỉnh điểm khi có một chị da đẹp thật đẹp, căng mọng đã cho biết sử dụng mặt nạ này. Xuất xứ : Hàn Quốc ', 'BNBG', 4, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230006', 'Mặt Nạ BNBG Vitamin C Chống Oxy Hóa, Làm Sáng Da', 17000, 'P182230006/matna_bnbg_vitaminc.jpg', 'Mặt nạ được xem như vị cứu tinh đối với làn da bạn. BNBG Vita Genic Jelly Mask chứa dưỡng chất Vitamin dạng gel đậm đặc, hàm lượng lên đến 20.000ppm được chiết xuất từ các trái cây tươi ở hòn đảo Jeju xinh đẹp. Mang đến làn da khỏe mạnh, bóng mượt đầy sức sống, phục hồi độ đàn hồi, ngăn ngừa quá trình lão hóa đồng thời cung cấp đủ ẩm cho da luôn mềm, mịn màng. Khi sử dụng BNBG Vita Genic Jelly Mask, bạn sẽ được trải nghiệm cảm giác thư giãn và sảng khoái.  BNBG được biết đến là một bệnh viện thẩm mỹ nổi tiếng với đội ngũ bác sĩ có tay nghề hàng đầu tại Hàn Quốc. Là bệnh viện ứng dụng các công nghệ hiện đại tại Châu Á để nghiên cứu ra các loại mỹ phẩm chăm sóc da cũng như các phương pháp phẫu thuật mới để mang lại vẻ đẹp hoàn thiện cho phụ nữ. Chương trình làm đẹp uy tín tại Hàn Quốc Get It Beauty đã đẩy cơn sốt mặt nạ jelly này lên đỉnh điểm khi có một chị da đẹp thật đẹp, căng mọng đã cho biết sử dụng mặt nạ này. Xuất xứ : Hàn Quốc ', 'BNBG', 4, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230007', 'Mặt Nạ BNBG Dưỡng Săn Chắc Da, Ngăn Ngừa Lão Hóa', 27000, 'P182230007/matna_bnbg.jpg', 'BNBG là bệnh viện thẩm mỹ lớn có uy tín của Hàn Quốc và đã có trụ sở tại nhiều quốc gia khác nhau. Thương hiệu này được tạo ra thông qua thực nghiệm lâm sàng và tâm huyết nghiên cứu suốt 15 năm của các chuyên gia khoa da với mục đích mang lại giải pháp về làm sáng da và ngừa lão hóa đồng thời giải quyết các mối lo ngại lớn nhất của các bệnh nhân nữ khi tìm đến bệnh viện.  Trước đây, khi hãng BNBG đã cho ra mắt loạt mặt nạ phiên bản “viên thuốc” Vita Genic Jelley Mask cũng đã làm mưa làm gió trong cộng đồng làm đẹp suốt thời gian dài bởi tác dụng trong việc săn sóc da. Nay hãng BNBG lại tung ra phiên bản cải tiến Vita Cocktail Foil Mask còn tuyệt hơn cả phiên bản cũ. Xuất xứ : Hàn Quốc ', 'BNBG', 4, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230008', 'Serum GoodnDoc Dưỡng Ẩm, Hỗ Trợ Phục Hồi Da', 365000, 'P182230008/serum_goodndoc.jpg', 'Tinh Chất GoodnDoc Hydra B5 Serum là sản phẩm serum dưỡng da đến từ thương hiệu GoodnDoc của Hàn Quốc, chứa thành phần Pro-Vitamin B5 kết hợp cùng Hyaluronic Acid, Adenosine và Niacinamide giúp dưỡng ẩm chuyên sâu và hỗ trợ phục hồi làn da tổn thương, kích ứng. Giúp da luôn căng đầy sức sống, trẻ hóa và căng mịn da. Bảo vệ làn da của bạn khỏi cháy nắng, nám tàn nhang da. Phục hồi tăng cường độ đàn hồi cho da, giúp da khô ráp trở nên mịn màng và trẻ trung hơn. Xuất xứ : Hàn Quốc ', 'GoodnDoc', 5, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230009', 'Serum Balance Active Formula Vitamin C Sáng Da', 128000, 'P182230009/serum_balance_active_formula.jpg', 'Vitamin C Brightening Serum Glow & Radiance là sản phẩm serum dưỡng sáng da, mờ thâm đến từ thương hiệu Balance Active Formula, với thành phần chính là Vitamin C nhưng tối ưu hơn nhờ sử dụng các dạng thức ổn định và hiệu quả nhất của Vitamin C. Sản phẩm chứa Vitamin C với nồng độ an toàn cho da, không gây kích ứng và dễ bảo quản.  Serum dạng lỏng nhẹ, không nhờn dính, chứa 2 thành phần vitamin C ổn định là 6% Illumiscin® và 3% Stay-C 50 giúp nuôi dưỡng cho làn da tươi sáng, rạng rỡ và đều màu hơn trông thấy chỉ sau vài tuần sử dụng, đồng thời làm da trở nên căng bóng mượt mà hơn, giảm thiểu các dấu hiệu lão hóa da Xuất xứ : Anh ', 'Balance Active Formula', 5, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230010', 'Serum Balance Active Formula Ngừa Mụn Mờ Thâm', 139000, 'P182230010/serum_balance_active_vitamin_c.jpg', 'Tinh Chất Balance Active Formula Niacinamide 15% Blemish Recovery Serum là sản phẩm serum mới ra mắt từ thương hiệu Balance Active Formula, với dạng lỏng nhẹ như nước và nồng độ 15% Niacinamide - một loại Vitamin B3 tự nhiên giúp giảm dầu thừa, giúp lỗ chân lông được thu nhỏ lại. Đồng thời, làm giảm các nhược điểm trên da và làm mờ vết thâm, giúp cải thiện kết cấu da và khuyến khích làn da khỏe mạnh. Xuất xứ : Anh ', 'Balance Active Formula', 5, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230011', 'Kem Dưỡng Ẩm Neutrogena Cấp Nước Cho Da Dầu', 274000, 'P182230011/kemduongam_neutrogena.jpg', 'Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel 50g là kem dưỡng ẩm đến từ thương hiệu mỹ phẩm Neutrogena của Mỹ, bảo vệ độ ẩm cho da mạnh hơn 80% cùng với công thức 1% các yếu tố giữ ẩm tự nhiên chứa Hyaluronic Acid, Axit Amin và chất điện giải. Kết cấu nhẹ thích hợp sử dụng hàng ngày.  Với công thức chăm sóc da cải tiến và đã qua kiểm nghiệm da liễu, Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel 50g giúp kích hoạt khả năng tiềm ẩn của làn da - tự sản sinh ra hàm lượng Hyaluronic Acid tự nhiên của hàng triệu tế bào da, từ đó mang lại độ ẩm dồi dào và dài lâu hơn, duy trì làn da thật ẩm mịn và căng mướt. Sản phẩm phù hợp cho cả nam lẫn nữ và đặc biệt lý tưởng cho làn da từ thường đến dầu, da đang gặp tình trạng thiếu nước. Xuất xứ : Mỹ ', 'Neutrogena', 6, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230012', 'Nước Hoa Hồng Klairs Không Mùi Cho Da Nhạy Cảm', 239000, 'P182230012/nuochoahong_klairs.jpg', 'Nước Hoa Hồng Klairs Supple Preparation Facial Toner chứa công thức các chiết xuất từ thực vật tự nhiên bao gồm nước cất Lavender, hoạt chất Phyto-Oligo, chiết xuất rau má cùng thành phần Hyaluronic Acid, Vitamin E & B5 giúp nhanh chóng làm dịu làn da mụn nhạy cảm và kích ứng, đồng thời cấp ẩm cho da mềm mịn và cân bằng độ pH trên da, hỗ trợ cho da hấp thu tối đa các dưỡng chất từ những bước chăm sóc tiếp theo. Sản phẩm có kết cấu dạng lỏng nhẹ, trong suốt và không màu, thẩm thấu nhanh chóng vào da. Kết hợp cùng mùi hương thảo mộc vô cùng dễ chịu, hoàn toàn không gây kích ứng hay cảm giác nhờn dính Xuất xứ : Hàn quốc ', 'Klairs', 7, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230013', 'Nước Hoa Hồng Simple Làm Dịu Da & Cấp Ẩm', 48000, 'P182230013/nuochoahong_simple.jpg', 'Nước Hoa Hồng Simple Kind to Skin Soothing Facial Toner đến từ thương hiệu chăm sóc da Simple xuất xứ Anh Quốc là sản phẩm Toner không chứa cồn được thiết kế phù hợp cho làn da nhạy cảm và dễ nổi mụn, giúp làm sạch sâu và cân bằng độ pH, cung cấp độ ẩm dịu nhẹ cho làn da, mang lại cảm giác tươi mát và sảng khoái sau khi sử dụng. Xuất xứ : Anh ', 'Simple', 7, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230014', 'Nước Cân Bằng La Roche-Posay Giàu Khoáng Cho Da Dầu', 365000, 'P182230014/toner_roche-posay.jpg', 'Nước Cân Bằng La Roche-Posay Effaclar Astringent Lotion là Toner thuộc dòng Effaclar của thương hiệu dược mỹ phẩm La Roche-Posay được phát triển chuyên dành cho làn da dầu mụn cần được chăm sóc một cách đặc biệt. Với thành phần giàu nước khoáng thiên nhiên, sản phẩm giúp làm dịu da, bảo vệ và chống oxy hóa; đồng thời làm sạch sâu, kiểm soát dầu thừa & hỗ trợ thu nhỏ lỗ chân lông với BHA & LHA, mang lại làn da thông thoáng. Xuất xứ : Pháp ', 'Roche-Posay', 8, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230015', 'Nước Cân Bằng Cocoon Chiết Xuất Bí Đao', 265000, 'P182230015/toner_cocoon.jpg', 'Bí đao là loại quả vô cùng quen thuộc trong đời sống của người dân Việt Nam. Thế nhưng không chỉ là một loại quả mát lành giúp giải nhiệt cơ thể trong những ngày hè nóng bức, bí đao còn có nhiều lợi ích cho làn da của chúng ta. Trong quả bí đao rất giàu những thành phần chống oxy hóa và kháng viêm như Vitamin A và C, giúp hỗ trợ làm giảm sưng viêm mụn và ngăn ngừa các tổn thương da do gốc tự do, đồng thời dưỡng da sáng mịn hồng hào. Thường xuyên sử dụng bí đao sẽ giúp tăng sức đề kháng cho làn da, làm mềm và cung cấp dưỡng chất nuôi da khỏe lên mỗi ngày.  Mien Spa xin giới thiệu đến các bạn một sản phẩm chăm sóc da độc đáo được chiết xuất từ thành phần bí đao đến từ thương hiệu mỹ phẩm Việt Nam Cocoon – Nước Bí Đao Cân Bằng Da Cocoon Winter Melon Toner. Là bước tiếp nối sau khi dùng Gel Bí Đao Rửa Mặt Cocoon Winter Melon Cleanser, nước bí đao Cocoon với công thức không chứa cồn cùng thành phần giàu các chiết xuất tự nhiên bao gồm chiết xuất bí đao, chiết xuất rau má và tinh dầu tràm trà sẽ giúp cân bằng độ pH cho da, làm sạch sâu lỗ chân lông, giảm dầu thừa và mụn ẩn dưới da hiệu quả. Ngoài ra sản phẩm còn được bổ sung thêm Vitamin B3, HA và chiết xuất cam thảo cung cấp độ ẩm giúp da luôn mịn màng và giảm thiểu các vết đỏ trên da. Nước Bí Đao Cân Bằng Da Cocoon Winter Melon Toner sẽ là sự lựa chọn tuyệt vời cho những làn da dầu bị mụn. Xuất xứ : Việt Nam ', 'Cocoon', 8, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230016', 'Nước Cân Bằng SVR Sebiaclear Dành Cho Da Dầu', 295000, 'P182230016/toner_svr_sebiaclear.jpg', 'Nước Cân Bằng SVR Sebiaclear Dành Cho Da Dầu, Mụn 150ml là sản phẩm toner làm sạch mới đến từ thương hiệu dược mỹ phẩm SVR của Pháp, được thiết kế chuyên biệt dành cho làn da dầu, mụn. Công thức được bào chế với 90% thành phần tự nhiên và các thành phần hoạt tính nồng độ cao, giúp chăm sóc và cải thiện các khuyết điểm, làm sạch da và thông thoáng lỗ chân lông, ngăn ngừa và làm giảm mụn. Kết quả mang lại một làn da sạch thoáng, mịn màng và tươi sáng hơn. Xuất xứ : Pháp ', 'SVR Sebiaclear', 8, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230017', 'Sữa Chống Nắng Sunplay Skin Aqua Dưỡng Da Sáng Mịn', 81000, 'P182230017/kemchongnang_sunplay.jpg', 'Sữa Chống Nắng Sunplay Skin Aqua Clear White SPF50+ PA++++ là dòng sản phẩm chống nắng cho da mặt đến từ thương hiệu chống nắng Sunplay Skin Aqua, với công thức cải tiến mới năm 2021, ứng dụng công nghệ CHỐNG NẮNG - GIỮ ẨM đột phá từ Nhật Bản giúp chống nắng mạnh mẽ và bền bì trên da, đồng thời hạn chế tình trạng mất nước và duy trì độ ẩm tối ưu. Đặc biệt, sản phẩm còn có công dụng kiểm soát bã nhờn và dưỡng da sáng mịn đều màu, là giải pháp lý tưởng dành cho các cô nàng da dầu nhờn trong mùa hè nóng bức. Xuất xứ : Việt Nam ', 'Sunplay', 9, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230018', 'Kem Chống Nắng La Roche-Posay Không Màu Kiểm Soát Dầu', 175000, 'P182230018/kemchongnang_la-roche-posay.jpg', 'Kem Chống Nắng La Roche-Posay Anthelios Anti-Shine Gel-Cream Dry Touch Finish Mattifying Effect SPF50+ đến từ thương hiệu dược mỹ phẩm La Roche-Posay là sản phẩm kem chống nắng dành cho làn da dầu mụn, sở hữu công nghệ cải tiến XL-Protect cùng kết cấu kem gel dịu nhẹ & không nhờn rít, giúp ngăn ngừa tia UVA/UVB + tia hồng ngoại + tác hại từ ô nhiễm, bảo vệ toàn diện cho làn da luôn khỏe mạnh. Xuất xứ : Pháp ', 'Roche-Posay', 9, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230019', 'Sữa Chống Nắng Sunplay Skin Aqua Dưỡng Da Sáng Mịn', 81000, 'P182230019/kemchongnang_sunplay.jpg', 'Sữa Chống Nắng Sunplay Skin Aqua Clear White SPF50+ PA++++ là dòng sản phẩm chống nắng cho da mặt đến từ thương hiệu chống nắng Sunplay Skin Aqua, với công thức cải tiến mới năm 2021, ứng dụng công nghệ CHỐNG NẮNG - GIỮ ẨM đột phá từ Nhật Bản giúp chống nắng mạnh mẽ và bền bì trên da, đồng thời hạn chế tình trạng mất nước và duy trì độ ẩm tối ưu. Đặc biệt, sản phẩm còn có công dụng kiểm soát bã nhờn và dưỡng da sáng mịn đều màu, là giải pháp lý tưởng dành cho các cô nàng da dầu nhờn trong mùa hè nóng bức. Xuất xứ : Việt Nam ', 'Sunplay', 9, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230020', 'Gel Sữa Chống Nắng Senka Ẩm Mượt Cho Da Khô', 129000, 'P182230020/kemchongnang_senka.jpg', 'Gel Sữa Chống Nắng SENKA Perfect UV Gel SPF50/PA++++ 80g là dòng sản phẩm chống nắng da mặt đến từ thương hiệu mỹ phẩm Senka của Nhật Bản, với chỉ số chống nắng phổ rộng vượt trội SPF 50+ PA++++ bảo vệ da khỏi tác hại của tia tử ngoại, ngăn ngừa sự hình thành của đốm nâu, sạm da, có thể dùng như lớp lót trang điểm. Xuất xứ : Nhật Bản  ', 'SENKA', 9, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0),
('P182230021', 'Kem Dưỡng Mắt Meishoku Ngừa Lão Hóa, Giảm Quầng Thâm', 241000, 'P182230021/kemduongmat_meishoku.jpg', 'Kem Dưỡng Mắt Meishoku Ngăn Ngừa Lão Hóa, Quầng Thâm Bọng Mắt là dòng kem dưỡng mắt đến từ thương hiệu mỹ phẩm Meishoku của Nhật Bản, với chiết xuất thành phần chính từ vitamin E và nhau thai Placenta, collagen,...có tác dụng ngăn ngừa lão hóa và giúp làm giảm thâm quầng, bọng mắt. Chính chất lượng hiệu quả đã giúp sản phẩm liên tiếp nằm trong top sản phẩm kem dưỡng vùng mắt được nhiều người lựa chọn. Xuất xứ : Nhật Bản  ', 'Meishoku', 10, 1, '2023-02-17 19:07:27', '2023-02-17 19:07:27', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `refreshtoken`
--

CREATE TABLE `refreshtoken` (
  `Id` int(11) NOT NULL,
  `User_Id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `Token` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `JwtId` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `IsUsed` bit(1) NOT NULL,
  `IsRevorked` bit(1) NOT NULL,
  `AddedDate` datetime DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `refreshtoken`
--

INSERT INTO `refreshtoken` (`Id`, `User_Id`, `Token`, `JwtId`, `IsUsed`, `IsRevorked`, `AddedDate`, `ExpiryDate`) VALUES
(1, 'MS172230001', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZDYxMTIwMDJAZ21haWwuY29tIiwiaWQiOiJNUzE3MjIzMDAwMSIsIm5hbWUiOiJIb2FuZyIsImlhdCI6MTY3NjY0MDI5NiwiZXhwIjoxNjc2NjQwNjU2fQ.g63ujp0wAXHSE0T5mOiCLLd02dhlqY8HVHd3loIbhEwcdlwfufKiNPEUe6mPGJgXPCqj2FyqzxvkjBSe5is9rg', 'd96a2ccd-cf3d-430a-aaa3-f3f70c947866', b'0', b'0', '2023-02-17 20:24:56', '2023-02-17 20:36:56'),
(2, 'MS172230001', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZDYxMTIwMDJAZ21haWwuY29tIiwiaWQiOiJNUzE3MjIzMDAwMSIsIm5hbWUiOiJIb2FuZyIsImlhdCI6MTY3NjY0MDg3NywiZXhwIjoxNjc2NjQxMjM3fQ.dIlkAdO8kLuxrF07ItYLRpKxvg1xfPHkvsWD9ZgkPG2yJhXcx215eYDUym5Svp1--r5lc7a5NXy0I7f8JDYJLg', '77f40f4a-98a9-456c-8b16-9719df943fdf', b'0', b'0', '2023-02-17 20:34:37', '2023-02-17 20:46:37'),
(3, 'MS172230001', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZDYxMTIwMDJAZ21haWwuY29tIiwiaWQiOiJNUzE3MjIzMDAwMSIsIm5hbWUiOiJIb2FuZyIsImlhdCI6MTY3NjY0MzIyNSwiZXhwIjoxNjc2NjQzNTg1fQ.3puz_VcvSJeGySKRLtt9mCKvxX3EX0kZJr06boq_2UpID_jxJVpvr3k8IzPbEXXaPXfupD3KOWgPSR7yku3mZg', '4b634611-4446-4728-a0d3-bae0fbba9acc', b'0', b'0', '2023-02-17 21:13:45', '2023-02-17 21:25:45'),
(4, 'MS172230002', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0YW9uaWNrY2hvdnVpMTIzQGdtYWlsLmNvbSIsImlkIjoiTVMxNzIyMzAwMDIiLCJuYW1lIjoibHlraWVuaG9uZyIsImlhdCI6MTY3NjY1MTUwNCwiZXhwIjoxNjc2NjUxODY0fQ.mzg37536f-wRpSe4ch_rQV8GWOlBtef4X1FAN9tiZOAmwTzyHf0LCl5I2gycsMAoPiAJ1mO_H2uWe4tshGmlRw', '392afa61-183c-489c-8c17-f7e32e918209', b'0', b'0', '2023-02-17 23:31:44', '2023-02-17 23:43:44'),
(5, 'MS172230001', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJoZDYxMTIwMDJAZ21haWwuY29tIiwiaWQiOiJNUzE3MjIzMDAwMSIsIm5hbWUiOiJIb2FuZyIsImlhdCI6MTY3NjcwNzg1MywiZXhwIjoxNjc2NzA4MjEzfQ.5o3tLGAPWRrf9DmXP97mTYS81k28CZ-ejLLj5DdiDBQ2iRmxryWZj_xbH0rjMNiA3DMuAzMj-udaFf0XuXlQfA', '01307b76-9d7d-4a3a-a6f0-7f44093833dc', b'0', b'0', '2023-02-18 15:10:53', '2023-02-18 15:22:53');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `ro_Id` int(11) NOT NULL,
  `ro_Name` varchar(250) COLLATE utf8_vietnamese_ci NOT NULL,
  `ro_DisplayName` varchar(250) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`ro_Id`, `ro_Name`, `ro_DisplayName`, `created_at`, `updated_at`) VALUES
(1, 'ROLE_USER', 'Quản lý các tài khoản của khách hàng', '2022-11-12 04:58:50', NULL),
(2, 'ROLE_MODERATOR', 'Quản lý các tài khoản có quyền chỉnh sửa', '2022-11-12 04:59:02', NULL),
(3, 'ROLE_ADMIN', 'Quản lý các tài khoản của admin', '2022-11-12 04:59:09', NULL),
(4, 'ROLE_CATEGORY', 'Quản lý các tài khoản có quyền quản lý category', '2022-11-12 04:59:09', NULL),
(5, 'ROLE_ORDER_SERVICE', 'Quản lý các tài có quyền quản lý đơn hàng dịch vụ', '2022-11-12 05:00:01', NULL),
(6, 'ROLE_ORDER_PRODUCT', 'Quản lý các tài có quyền quản lý đơn hàng sản phẩm', '2022-11-12 05:00:01', NULL),
(7, 'ROLE_PRODUCT', 'Quản lý các tài khoản đang quản lý sản phẩm', '2022-11-12 05:00:59', NULL),
(8, 'ROLE_SERVICE', 'Quản lý các tài khoản đang quản lý dịch vụ', '2022-11-12 05:00:59', NULL),
(9, 'ROLE_SHOPINFOR', 'Quản lý các tài khoản có quyền chỉnh sửa thông tin shop', '2022-11-12 05:02:05', NULL),
(10, 'ROLE_ACCOUNT', 'Quản lý các tài khoản có quyền quản lí tài khoản', '2022-11-12 05:02:05', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `serce`
--

CREATE TABLE `serce` (
  `se_Id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `se_Name` text COLLATE utf8_vietnamese_ci NOT NULL,
  `se_Price` int(11) NOT NULL,
  `se_Description` text COLLATE utf8_vietnamese_ci NOT NULL,
  `se_Note` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `se_Image` varchar(250) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `se_TurnOn` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `serce`
--

INSERT INTO `serce` (`se_Id`, `se_Name`, `se_Price`, `se_Description`, `se_Note`, `se_Image`, `se_TurnOn`, `created_at`, `updated_at`, `isDelete`) VALUES
('S172230001', 'Điều trị mụn', 300000, 'Mụn là một trong những trở ngại khiến mọi người dễ mất tự ti với làn da khuyết điểm. Đây là bệnh lý về da mặt mà tất cả chúng ta đều đã từng mắc phải, nhất là giai đoạn dậy thì. Tùy từng trường hợp da mà xuất hiện nhiều loại mụn khác nhau: mụn đầu đen, mụn đỏ, mụn nhọt,.. ', 'Để điều trị mụn cũng không phải đơn giản, khi bạn tự nặn mụn tại nhà, quy trình dễ bị sai cách và dẫn đến nguy cơ nhiễm trùng hoặc sử dụng các phương pháp nặn không đúng cách lâu dần sẽ để lại sẹo thâm. Hiện nay cách tiêu diệt mụn hiệu quả nhất của nhiều chị em là tìm đến Spa điều trị. ', 'S172230001/dieutrimun.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230002', 'Tẩy wax lông', 240000, 'Wax lông là phương pháp sẽ đem lại những tác động tích cực đến làn da, giúp thuận lợi trong quá trình tẩy da chết trên da. Lông sau khi wax thường mọc lại chậm và thưa hơn. Ít bị đau hay kích ứng da nếu bạn thực hiện đúng cách. Việc lựa chọn Spa để thực hiện quá trình này là sự lựa chọn đúng đắn.  ', 'Các bước wax lông tại các Spa nhỏ bao gồm:  -Bước 1 : Làm sạch vùng da cần wax bằng nước ấm, sau đó phủ phấn rôm để giúp da mềm mịn hơn. -Bước 2 : Sử dụng que lấy lượng sáp vừa đủ bôi lên vùng da cần waxing theo chiều lông mọc. -Bước 3 : Đặt giấy waxing lên vùng da đã bôi sáp và miết nhẹ. -Bước 4 : Khi sáp khô, giật nhẹ giấy waxing ra theo hướng ngược chiều lông mọc. -Bước 5 : Sau cùng, phủ lại một lớp phấn rôm cho vùng da vừa waxing và kết thúc liệu trình. ', 'S172230002/waxlong.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230003', 'Massage', 150000, 'Là hình thức thư giãn phổ biến mà bất cứ các spa chăm sóc sức khỏe nào cũng có. Dựa trên sự phát triển tiếp thu văn hoá mà các tiệm spa hiện nay ngày càng thay đổi, đa dạng hơn để phù hợp với lối sống chung của xã hội. Giúp hỗ trợ cân bằng khí huyết, đẩy lùi các bệnh về xương khớp và nhìn chung với các loại mô hình massage nào cũng đầy đủ các dụng cụ cần thiết như: tinh dầu,khăn, gối và giường massage,.. ', '', 'S172230003/massage.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230004', 'Chăm sóc da mặt', 230000, 'Phương pháp phổ biến chuyên giải quyết các vấn đề về da như khô ráp, thiếu sức sống, lão hoá. Tuỳ thuộc vào làn da mà tại các tiệm spa luôn có các liệu trình phù hợp. Sau đây là những lưu ý khi bạn muốn đăng ký chăm sóc da mặt ở các spa ', 'Chăm sóc da mặt thường kèm theo  nhiều dịch vụ nhỏ  để đảm bảo tính hiệu quả khi sử dụng gói dịch vụ chung. Ngoài ra, các spa còn tinh ý tạo  thư giãn bằng cách sử dụng tinh dầu thiên nhiên vừa có tác dụng làm đẹp, hương thơm thoảng giúp bạn cảm thấy cảm giác thoải mái dễ chịu, xua tan mệt mỏi', 'S172230004/chamsocdamat.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230005', 'Tắm trắng', 500000, 'Nhu cầu làm trắng hiện nay ngày càng được chị em phụ nữ quan tâm và sử dụng. Chính vì thế, các tiệm spa lớn nhỏ bắt đầu triển khai loại hình dịch vụ này cũng như sử dụng nhiều liệu pháp khác nhau để mang lại hiệu quả nổi bật cho người sử dụng. Một số phương pháp tắm trắng phổ biến ', 'Nhu cầu làm trắng thường kèm theo  nhiều dịch vụ nhỏ  để đảm bảo tính hiệu quả khi sử dụng gói dịch vụ chung. Ngoài ra, các spa còn tinh ý tạo  thư giãn bằng cách sử dụng tinh dầu thiên nhiên vừa có tác dụng làm đẹp, hương thơm thoảng giúp bạn cảm thấy cảm giác thoải mái dễ chịu, xua tan mệt mỏi', 'S172230005/lamtrangda.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230006', 'Giảm mỡ, giảm cân', 400000, 'Các phương pháp giảm mỡ luôn được nhiều chị em quan tâm, tìm kiếm và áp dụng. Chúng ta cũng có nhiều cách giảm cân tại nhà nhưng đem lại không nhiều lợi ích, cùng như mất khá nhiều thời gian. Khi bạn đến spa, bạn vừa được thư giãn với không gian thoải mái, vừa tiết kiệm tối đa thời gian và nhận thấy được sự thay đổi ngay tức khắc. Đó là điều mà chị em chúng ta luôn mong muốn và đạt được ', 'Ở các spa thẩm mỹ thường có đầy đủ các trang thiết bị tiên tiến và đội ngũ bác sĩ, chuyên viên tay nghề cao góp phần  lựa chọn loại liệu trình phù hợp. Sau đó, bạn sẽ được hướng dẫn chi tiết cách làm tan mỡ sau khi hoàn thành tốt các bước tại Spa để duy trì được vóc dáng.  Trước tình trạng bận rộn trước công việc dẫn đến ăn uống thất thường và không có thời gian tập thể dục khiến chúng ta kém tự tin. Vì lẽ đó giải pháp Spa giảm béo là luôn cần thiết trong các gói dịch vụ spa hiện nay', 'S172230006/giamo.jpg', 1, '2023-02-17 14:34:46', '2023-02-17 14:34:46', 0),
('S172230007', 'Dịch vụ trị nám, tàn nhang', 150000, 'Phụ nữ sau độ tuổi 30 da thường xuất hiện dấu hiệu của lão hóa. Những mảng thâm, nám dần xuất hiện, làn da trở nên loang lổ không đều màu, làm cho làn da trở nên mất sức sống và mất tự tin khi họ giao tiếp.  Để che đi các vết nám, tàn nhang nhiều người sử dụng trang điểm. Tuy nhiên việc trang điểm gây mất khá nhiều thời gian, ảnh hưởng xấu đến sức khỏe của da về sau.', 'Nắm được những điều này thì các spa đã cung cấp các dịch vụ trị nám, tàn nhang trên khuôn mặt chị em giúp cho làn da lấy lại được sự tươi trẻ. Đây là một trong những dịch vụ thu hút được khá nhiều khách hàng.', 'S172230007/trinamtannhang.png', 1, '2023-02-17 14:51:37', '2023-02-17 14:51:37', 0),
('S182230001', 'Tẩy da chết toàn thân', 500000, 'Mỗi ngày, cơ thể của bạn thường xuyên phải tiếp xúc với ánh nắng mặt trời, khói bụi, làm cho làn da dần trở nên lão hóa. Trong thời tiết lạnh thì da còn bị khô, tróc vảy khiến việc sử dụng mỹ phẩm kém hiệu quả. Cũng như da mặt, làn da trên cơ thể cũng cần được chăm sóc để loại bỏ bụi bẩn. Tẩy tế bào da chết giúp làn da luôn mịn màng, tươi sáng, thúc đẩy quá trình phát triển của tế bào da mới, đem đến cho bạn một làn da trẻ trung một cách tự nhiên.', 'Ngoài tác dụng tẩy da chết, dịch vụ spa này còn giúp bạn dành những phút giây thư giãn cho cả cơ thể và tâm hồn.', 'S182230001/taydachettoanthan.jpg', 1, '2023-02-17 19:37:09', '2023-02-17 19:37:09', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shopinfo`
--

CREATE TABLE `shopinfo` (
  `shi_Id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_Name` text COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_Address` varchar(250) COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_PhoneNo` varchar(15) COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_BossName` text COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_LogoImage` varchar(250) COLLATE utf8_vietnamese_ci NOT NULL,
  `shi_Note` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `us_Id` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `us_UserName` text COLLATE utf8_vietnamese_ci NOT NULL,
  `us_Password` text COLLATE utf8_vietnamese_ci NOT NULL,
  `us_Dob` varchar(20) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `us_Address` varchar(150) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `us_PhoneNo` varchar(15) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `us_EmailNo` varchar(150) COLLATE utf8_vietnamese_ci NOT NULL,
  `us_Image` varchar(250) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `us_Note` text COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isDelete` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`us_Id`, `us_UserName`, `us_Password`, `us_Dob`, `us_Address`, `us_PhoneNo`, `us_EmailNo`, `us_Image`, `us_Note`, `is_admin`, `created_at`, `updated_at`, `isDelete`) VALUES
('MS172230001', 'Hoang', '$2a$12$j9.FeK15L8O6gI6bKtWSxOsP3DY5eDuoQUIvFVQAmzwEkxmDpUz5e', NULL, NULL, NULL, 'hd6112002@gmail.com', NULL, NULL, 1, '2023-02-17 07:07:46', NULL, NULL),
('MS172230002', 'lykienhong', '$2a$10$hUo1VaL3CKwesWFvlxLlb.Me4OfsZ8vdAUDMrCWTcMCCkbPpoH8Pm', '01/01/1997', '111 Đường Tân Sơn Nhì, Tân Sơn Nhì, Tân Phú, Ho Chi Minh City, Vietnam', '0938887761', 'taonickchovui123@gmail.com', 'MS172230002/image_cropper_1676651558995.jpg', NULL, 0, '2023-02-17 16:31:23', '2023-02-17 23:32:21', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_role`
--

CREATE TABLE `user_role` (
  `usr_Id` int(11) NOT NULL,
  `usr_UserId` varchar(128) COLLATE utf8_vietnamese_ci NOT NULL,
  `usr_RoleId` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `user_role`
--

INSERT INTO `user_role` (`usr_Id`, `usr_UserId`, `usr_RoleId`, `created_at`, `updated_at`) VALUES
(4, 'MS172230001', 1, NULL, NULL),
(5, 'MS172230001', 2, NULL, NULL),
(6, 'MS172230001', 4, NULL, NULL),
(7, 'MS172230001', 3, NULL, NULL),
(8, 'MS172230002', 1, NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cate_id`);

--
-- Chỉ mục cho bảng `orderserdetail`
--
ALTER TABLE `orderserdetail`
  ADD PRIMARY KEY (`ordSer_Id`),
  ADD KEY `fk_OrderSerDetail_Orders_OrderId` (`ordSer_OrderId`),
  ADD KEY `fk_OrderSerDetail_Serce_ServiceId` (`ordSer_ServiceId`);

--
-- Chỉ mục cho bảng `orderspro`
--
ALTER TABLE `orderspro`
  ADD PRIMARY KEY (`orPro_id`),
  ADD KEY `fk_OrdersPro_User_UserId` (`orPro_UserId`);

--
-- Chỉ mục cho bảng `ordersprodetail`
--
ALTER TABLE `ordersprodetail`
  ADD PRIMARY KEY (`ordPro_Id`),
  ADD KEY `fk_OrdersProDetail_OrdersPro_OrderId` (`ordPro_OrderId`),
  ADD KEY `fk_OrdersProDetail_Product_ProductId` (`ordPro_ProductId`);

--
-- Chỉ mục cho bảng `ordersser`
--
ALTER TABLE `ordersser`
  ADD PRIMARY KEY (`orSer_id`),
  ADD KEY `fk_OrdersSer_User_UserId` (`orSer_UserId`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pro_id`),
  ADD KEY `fk_Product_Category_CategoryI` (`category_id`);

--
-- Chỉ mục cho bảng `refreshtoken`
--
ALTER TABLE `refreshtoken`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_RefreshToken_User_UserId` (`User_Id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`ro_Id`);

--
-- Chỉ mục cho bảng `serce`
--
ALTER TABLE `serce`
  ADD PRIMARY KEY (`se_Id`);

--
-- Chỉ mục cho bảng `shopinfo`
--
ALTER TABLE `shopinfo`
  ADD PRIMARY KEY (`shi_Id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`us_Id`);

--
-- Chỉ mục cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`usr_Id`),
  ADD KEY `fk_User_Role_UserId` (`usr_UserId`),
  ADD KEY `fk_User_Role_RoleId` (`usr_RoleId`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `cate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `orderserdetail`
--
ALTER TABLE `orderserdetail`
  MODIFY `ordSer_Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `ordersprodetail`
--
ALTER TABLE `ordersprodetail`
  MODIFY `ordPro_Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `refreshtoken`
--
ALTER TABLE `refreshtoken`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `ro_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `user_role`
--
ALTER TABLE `user_role`
  MODIFY `usr_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orderserdetail`
--
ALTER TABLE `orderserdetail`
  ADD CONSTRAINT `fk_OrderSerDetail_Orders_OrderId` FOREIGN KEY (`ordSer_OrderId`) REFERENCES `ordersser` (`orSer_id`),
  ADD CONSTRAINT `fk_OrderSerDetail_Serce_ServiceId` FOREIGN KEY (`ordSer_ServiceId`) REFERENCES `serce` (`se_Id`);

--
-- Các ràng buộc cho bảng `orderspro`
--
ALTER TABLE `orderspro`
  ADD CONSTRAINT `fk_OrdersPro_User_UserId` FOREIGN KEY (`orPro_UserId`) REFERENCES `users` (`us_Id`);

--
-- Các ràng buộc cho bảng `ordersprodetail`
--
ALTER TABLE `ordersprodetail`
  ADD CONSTRAINT `fk_OrdersProDetail_OrdersPro_OrderId` FOREIGN KEY (`ordPro_OrderId`) REFERENCES `orderspro` (`orPro_id`),
  ADD CONSTRAINT `fk_OrdersProDetail_Product_ProductId` FOREIGN KEY (`ordPro_ProductId`) REFERENCES `product` (`pro_id`);

--
-- Các ràng buộc cho bảng `ordersser`
--
ALTER TABLE `ordersser`
  ADD CONSTRAINT `fk_OrdersSer_User_UserId` FOREIGN KEY (`orSer_UserId`) REFERENCES `users` (`us_Id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_Product_Category_CategoryI` FOREIGN KEY (`category_id`) REFERENCES `category` (`cate_id`);

--
-- Các ràng buộc cho bảng `refreshtoken`
--
ALTER TABLE `refreshtoken`
  ADD CONSTRAINT `fk_RefreshToken_User_UserId` FOREIGN KEY (`User_Id`) REFERENCES `users` (`us_Id`);

--
-- Các ràng buộc cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `fk_User_Role_RoleId` FOREIGN KEY (`usr_RoleId`) REFERENCES `role` (`ro_Id`),
  ADD CONSTRAINT `fk_User_Role_UserId` FOREIGN KEY (`usr_UserId`) REFERENCES `users` (`us_Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
