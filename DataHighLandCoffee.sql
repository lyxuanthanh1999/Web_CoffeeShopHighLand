USE [master]
GO
/****** Object:  Database [COFFE_HIGHLAND1]    Script Date: 8/30/2020 1:43:14 PM ******/
CREATE DATABASE [COFFE_HIGHLAND1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'COFFE_HIGHLAND1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\COFFE_HIGHLAND1.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'COFFE_HIGHLAND1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\COFFE_HIGHLAND1_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [COFFE_HIGHLAND1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ARITHABORT OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET  MULTI_USER 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [COFFE_HIGHLAND1]
GO
/****** Object:  StoredProcedure [dbo].[AddKhachHang]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AddKhachHang]
( 
	@HoTen nvarchar(50) ,
	@NgaySinh datetime ,
	@GioiTinh nvarchar(3) ,
	@DienThoai varchar(50) ,
	@TaiKhoan varchar(50) ,
	@MatKhau nvarchar(50) ,
	@Email varchar(50) ,
	@DiaChi nchar(10) 
)
as
	insert into KhachHang(HoTen,NgaySinh,GioiTinh,DienThoai,TaiKhoan,MatKhau,Email,DiaChi)
	Values (@HoTen,@NgaySinh,@GioiTinh,@DienThoai,@TaiKhoan,@MatKhau,@Email,@DiaChi)

GO
/****** Object:  StoredProcedure [dbo].[GetLoaiMonById]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetLoaiMonById]
(@Id int)
as
	select * from LoaiMon where LoaiMon.MaLoaiMon=@Id

GO
/****** Object:  StoredProcedure [dbo].[GetLoaiMons]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetLoaiMons]
as
	select * from LoaiMon

GO
/****** Object:  StoredProcedure [dbo].[GetMonCoMaLoaiRelation]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMonCoMaLoaiRelation](@Id INT, @LoaiMonId INT)
AS
	SELECT * FROM ThucDon WHERE MaMon <> @Id AND MaLoaiMon = @LoaiMonId;

GO
/****** Object:  StoredProcedure [dbo].[GetThucDonById]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetThucDonById]
(@Id int)
as
	select * from ThucDon where ThucDon.MaMon=@Id

GO
/****** Object:  StoredProcedure [dbo].[GetThucDonByMaLoaiId]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetThucDonByMaLoaiId]
(@Id int)
as
	select * from ThucDon a,LoaiMon b where a.MaLoaiMon=b.MaLoaiMon and b.MaLoaiMon=@Id

GO
/****** Object:  StoredProcedure [dbo].[GetThucDons]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetThucDons]
as
	select * from ThucDon

GO
/****** Object:  StoredProcedure [dbo].[GetTinTucById]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTinTucById]
(@Id int)
as
	select * from TinTuc where TinTuc.MaTin=@Id

GO
/****** Object:  StoredProcedure [dbo].[GetTinTucs]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTinTucs]
as
	select * from TinTuc

GO
/****** Object:  StoredProcedure [dbo].[GetTrachNhiemCongDongById]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTrachNhiemCongDongById]
(@Id int)
as
	select * from TrachNhiemCongDong where TrachNhiemCongDong.MaTNCD=@Id

GO
/****** Object:  StoredProcedure [dbo].[GetTrachNhiemCongDongs]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTrachNhiemCongDongs]
as
	select * from TrachNhiemCongDong

GO
/****** Object:  StoredProcedure [dbo].[IsMember]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[IsMember]
(
@TaiKhoan varchar(50),
@MatKhau nvarchar(50)
)
as
	select * from KhachHang where TaiKhoan=@TaiKhoan and MatKhau=@MatKhau

GO
/****** Object:  StoredProcedure [dbo].[OldMember]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[OldMember]
(
	@TaiKhoan varchar(50)
)
as
	select * from KhachHang where TaiKhoan=@TaiKhoan

GO
/****** Object:  StoredProcedure [dbo].[SignIn]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SignIn]
(
	@Username varchar(50),
	@MatKhau nvarchar(50)
)
as
Begin
	IF Exists(select * from KhachHang where TaiKhoan=@Username)
	Begin
		select * From KhachHang where TaiKhoan=@Username and MatKhau=@MatKhau
		return 1;
	End
	else
		return 0;
END

GO
/****** Object:  Table [dbo].[Admin]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[UserAdmin] [varchar](30) NOT NULL,
	[PassAdmin] [varchar](30) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserAdmin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaDonHang] [int] NOT NULL,
	[MaMon] [int] NOT NULL,
	[SoLuong] [int] NULL,
	[Dongia] [decimal](18, 0) NULL,
 CONSTRAINT [PK_CHITIETDONHANG] PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC,
	[MaMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonDatHang]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDatHang](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[DaThanhToan] [bit] NULL,
	[TinhTrangGiaoHang] [bit] NULL,
	[NgayGiao] [datetime] NULL,
	[NgayDat] [datetime] NULL,
	[MaKH] [int] NULL,
 CONSTRAINT [PK__DonDatHa__129584ADED657C1C] PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[DienThoai] [varchar](50) NULL,
	[TaiKhoan] [varchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[DiaChi] [nchar](10) NULL,
 CONSTRAINT [PK_KhachHang_1] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiMon]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiMon](
	[MaLoaiMon] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiMon] [nvarchar](64) NOT NULL,
	[MoTa] [nvarchar](512) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThucDon]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucDon](
	[MaMon] [int] IDENTITY(1,1) NOT NULL,
	[MaLoaiMon] [int] NOT NULL,
	[TenMon] [nvarchar](100) NULL,
	[MoTa] [nvarchar](1000) NULL,
	[Gia] [money] NULL,
	[Hinh] [nvarchar](max) NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinTuc]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinTuc](
	[MaTin] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](100) NULL,
	[NoiDung] [nvarchar](2000) NULL,
	[AnhTinTuc] [nvarchar](max) NULL,
	[NgayDang] [date] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrachNhiemCongDong]    Script Date: 8/30/2020 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrachNhiemCongDong](
	[MaTNCD] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](100) NULL,
	[NoiDung] [nvarchar](2000) NULL,
	[AnhTinTuc] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[Admin] ([UserAdmin], [PassAdmin], [HoTen]) VALUES (N'admin', N'123', N'Lý Xuân Thành')
INSERT [dbo].[Admin] ([UserAdmin], [PassAdmin], [HoTen]) VALUES (N'user', N'123', N'Trang Cute')
INSERT [dbo].[ChiTietDonHang] ([MaDonHang], [MaMon], [SoLuong], [Dongia]) VALUES (1, 1, 22, CAST(0 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[DonDatHang] ON 

INSERT [dbo].[DonDatHang] ([MaDonHang], [DaThanhToan], [TinhTrangGiaoHang], [NgayGiao], [NgayDat], [MaKH]) VALUES (1, 0, 0, CAST(0x0000AD9A00000000 AS DateTime), CAST(0x0000AD9A00000000 AS DateTime), 2)
INSERT [dbo].[DonDatHang] ([MaDonHang], [DaThanhToan], [TinhTrangGiaoHang], [NgayGiao], [NgayDat], [MaKH]) VALUES (2, 0, 0, CAST(0x0000AD9A00000000 AS DateTime), CAST(0x0000AD9A00000000 AS DateTime), 2)
INSERT [dbo].[DonDatHang] ([MaDonHang], [DaThanhToan], [TinhTrangGiaoHang], [NgayGiao], [NgayDat], [MaKH]) VALUES (3, 0, 0, CAST(0x0000AD9A00000000 AS DateTime), CAST(0x0000AD9A00000000 AS DateTime), 2)
INSERT [dbo].[DonDatHang] ([MaDonHang], [DaThanhToan], [TinhTrangGiaoHang], [NgayGiao], [NgayDat], [MaKH]) VALUES (4, 0, 0, CAST(0x0000AD9A00000000 AS DateTime), CAST(0x0000AD9A00000000 AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[DonDatHang] OFF
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (2, N'ga', CAST(0x0000AB0400000000 AS DateTime), NULL, N'12412125', N'aa', N'123', NULL, N'12fqqư    ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (7, N'ấgága', CAST(0x0000AAFC00000000 AS DateTime), NULL, N'12521512', N'ahaha', N'123', NULL, N'qưdưqfqư  ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (8, N'Lý Xuân Thành', CAST(0x0000AB0400000000 AS DateTime), NULL, N'2145325235', N'advgb', N'123', NULL, N'afaawàqừ  ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (9, N'aasdasd', CAST(0x0000AB0400000000 AS DateTime), NULL, N'04654660', N'123t', N'321', NULL, N'ágsagsa   ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (10, N'ga123312', CAST(0x0000AB0500000000 AS DateTime), NULL, N'10845405045', N'admin123123', N'123', NULL, N'ằqừqư     ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (11, N'thanh', CAST(0x0000AB2800000000 AS DateTime), N'nam', N'05889767890', N'ad', N'䈪Ზぉ若ᒪ陊自쉧', N'tyanh185@gmail.com', N'aduq      ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (12, N'thanh', CAST(0x0000AB1B00000000 AS DateTime), N'nam', N'05889767890', N'ad1', N'ad1@?@!123', N'tyanh185@gmail.com', N'aduq      ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [DienThoai], [TaiKhoan], [MatKhau], [Email], [DiaChi]) VALUES (13, N'thanh', CAST(0x0000AB3600000000 AS DateTime), N'nam', N'05889767890', N'ad2', N'C66081DDD372A86AC7D429541FB2EF4D', N'tyanh185@gmail.com', N'aduq      ')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
SET IDENTITY_INSERT [dbo].[LoaiMon] ON 

INSERT [dbo].[LoaiMon] ([MaLoaiMon], [TenLoaiMon], [MoTa]) VALUES (1, N'Freeze', N'Sảng khoái với thức uống đá xay phong cách Việt. Freeze là thức uống đá xay mát lạnh được pha chế từ cà phê Việt, trà xanh, sô cô la hay các loại trái cây đặc trưng của Việt Nam')
INSERT [dbo].[LoaiMon] ([MaLoaiMon], [TenLoaiMon], [MoTa]) VALUES (2, N'Cà phê', N'Sự kết hợp hoàn hảo giữa hạt cà phê Robusta &amp; Arabica thượng hạng được trồng trên những vùng cao nguyên Việt Nam màu mỡ, qua những bí quyết rang xay độc đáo, Highlands Coffee chúng tôi tự hào giới thiệu những dòng sản phẩm Cà phê mang hương vị đậm đà và tinh tế')
INSERT [dbo].[LoaiMon] ([MaLoaiMon], [TenLoaiMon], [MoTa]) VALUES (3, N'Trà', N'Hương vị tự nhiên, thơm ngon của Trà Việt với phong cách hiện đại tại Highlands Coffee sẽ giúp bạn gợi mở vị giác của bản thân và tận hưởng một cảm giác thật khoan khoái, tươi mới.')
INSERT [dbo].[LoaiMon] ([MaLoaiMon], [TenLoaiMon], [MoTa]) VALUES (4, N'Bánh mì', N'Bạn đã quá quen thuộc với Bánh mì Việt Nam. Hãy nếm thử một miếng Bánh mì ngon, giòn, nóng hổi tại Highlands Coffee. Một kết hợp hoàn hảo giữa lớp nhân chua, cay, mặn, ngọt quyện với lớp vỏ bánh mì giòn tan, mịn màng tạo ra tầng tầng lớp lớp dư vị cho thực khách.')
INSERT [dbo].[LoaiMon] ([MaLoaiMon], [TenLoaiMon], [MoTa]) VALUES (5, N'Khác', N'Sẽ càng ngon miệng hơn khi bạn kết hợp đồ uống với những chiếc bánh ngọt thơm ngon được làm thủ công hàng ngày ngay tại bếp bánh của Highlands Coffee, và cũng đừng quên sắm cho mình bộ bí kíp pha cà phê tại nhà gồm Phin inox, ly sứ Mosaic và cà phê gói Truyền thống mỗi khi có thời gian rảnh rỗi nhé.')
SET IDENTITY_INSERT [dbo].[LoaiMon] OFF
SET IDENTITY_INSERT [dbo].[ThucDon] ON 

INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (1, 1, N'Phin Sữa Đá', N'Hương vị cà phê Việt Nam đích thực! Từng hạt cà phê hảo hạng được chọn bằng tay, phối trộn độc đáo giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng. Cà phê được pha từ Phin truyền thống, hoà cùng sữa đặc sánh và thêm vào chút đá tạo nên ly Phin Sữa Đá – Đậm Đà Chất Phin.', 29000.0000, N'phin-sua-da.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (3, 1, N'Phin Đen Nóng', N'Hương vị cà phê Việt Nam đích thực! Từng hạt cà phê hảo hạng được chọn bằng tay, phối trộn độc đáo giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng. Kết hợp với nước sôi từng giọt cà phê được chiết xuất từ Phin truyền thống, hoà cùng sữa đặc sánh tạo nên ly Phin Sữa Nóng – Đậm đà chất Phin.', 29000.0000, N'phin-sua-nong.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (4, 1, N'Phin Sữa Nóng', N'Hương vị cà phê Việt Nam đích thực! Từng hạt cà phê hảo hạng được chọn bằng tay, phối trộn độc đáo giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng. Kết hợp với nước sôi từng giọt cà phê được chiết xuất từ Phin truyền thống, hoà cùng sữa đặc sánh tạo nên ly Phin Sữa Nóng – Đậm đà chất Phin.', 29000.0000, N'phin-sua-nong.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (5, 1, N'Mocha Macchiato', N'Một thức uống yêu thích được kết hợp bởi giữa sốt sô cô la ngọt ngào, sữa tươi và đặc biệt là cà phê espresso đậm đà mang thương hiệu Highlands Coffee. Bạn có thể tùy thích lựa chọn uống nóng hoặc dùng chung với đá.', 59000.0000, N'mocha-macchiato.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (6, 1, N'Espresso', N'Đích thực là ly cà phê espresso ngon đậm đà! Được chiết xuất một cách hoàn hảo từ loại cà phê rang được phối trộn độc đáo từ những hạt cà phê Robusta và Arabica chất lượng hảo hạng', 44000.0000, N'espresso.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (7, 1, N'Americano', N'Americano tại Highlands Coffee là sự kết hợp giữa cà phê espresso thêm vào nước đun sôi. Bạn có thể tùy thích lựa chọn uống nóng hoặc dùng chung với đá.', 44000.0000, N'americano.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (8, 1, N'Latte', N'Ly cà phê sữa ngọt ngào đến khó quên! Với một chút nhẹ nhàng hơn so với Cappuccino, Latte của chúng tôi bắt đầu với cà phê espresso, sau đó thêm sữa tươi và bọt sữa một cách đầy nghệ thuật. Bạn có thể tùy thích lựa chọn uống nóng hoặc dùng chung với đá.', 54000.0000, N'latte.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (9, 2, N'Caramel Phin Freeze', N'Thơm ngon khó cưỡng! Được kết hợp từ cà phê truyền thống chỉ có tại Highlands Coffee, cùng với caramel, thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và caramel ngọt ngào. Món nước phù hợp trong những cuộc gặp gỡ bạn bè, bởi sự ngọt ngào thường mang mọi người xích lại gần nhau. ', 49000.0000, N'caramel-phin-freeze.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (10, 2, N'Classic Phin Freeze', N'Thơm ngon đậm đà! Được kết hợp từ cà phê pha Phin truyền thống chỉ có tại Highlands Coffee, cùng với thạch cà phê và đá xay mát lạnh. Trên cùng là lớp kem tươi thơm béo và bột ca cao đậm đà. Món nước hoàn hảo để khởi đầu câu chuyện cùng bạn bè.', 49000.0000, N'classic-phin-freeze.png', 52)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (11, 2, N'Cookies & Cream', N'Một thức uống ngon lạ miệng bởi sự kết hợp hoàn hảo giữa cookies sô cô la giòn xốp cùng hỗn hợp sữa tươi cùng sữa đặc đem say với đá viên, và cuối cùng không thể thiếu được chính là lớp kem whip mềm mịn cùng cookies sô cô la say nhuyễn.', 49000.0000, N'cookies-cream.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (12, 2, N'Freeze Sô-cô-la', N'Thiên đường đá xay sô cô la! Từ những thanh sô cô la Việt Nam chất lượng được đem xay với đá cho đến khi mềm mịn, sau đó thêm vào thạch sô cô la dai giòn, ở trên được phủ một lớp kem whip beo béo và sốt sô cô la ngọt ngào. Tạo thành Freeze Sô-cô-la ngon mê mẩn chinh phục bất kì ai!', 49000.0000, N'freeze-socola.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (13, 2, N'Freeze Trà Xanh', N'Thức uống rất được ưa chuộng! Trà xanh thượng hạng từ cao nguyên Việt Nam, kết hợp cùng đá xay, thạch trà dai dai, thơm ngon và một lớp kem dày phủ lên trên vô cùng hấp dẫn. Freeze Trà Xanh thơm ngon, mát lạnh, chinh phục bất cứ ai!', 49000.0000, N'freeze-tra-xanh.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (14, 3, N'Trà Sen Vàng', N'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.', 39000.0000, N'tra-thach-vai.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (15, 3, N'Trà Thạch Vải', N'Một sự kết hợp thú vị giữa trà đen, những quả vải thơm ngon và thạch vàng giòn béo, mang đến thức uống tuyệt hảo!', 39000.0000, N'tra-thach-dao.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (16, 3, N'Trà Thạch Đào', N'Vị trà đậm đà kết hợp cùng những miếng đào thơm ngon mọng nước cùng thạch đào giòn dai. Thêm vào ít sữa để gia tăng vị béo.', 39000.0000, N'tra-thach-dao.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (17, 3, N'Trà Thanh Đào', N'Một trải nghiệm thú vị khác! Sự hài hòa giữa vị trà cao cấp, vị sả thanh mát và những miếng đào thơm ngon mọng nước sẽ mang đến cho bạn một thức uống tuyệt vời.', 39000.0000, N'tra-thanh-dao.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (18, 4, N'Thịt nướng', N'Đặc sản của Việt Nam! Bánh mì giòn với nhân thịt nướng, rau thơm và gia vị đậm đà, hòa quyện trong lớp nước sốt tuyệt hảo.', 19000.0000, N'thit-nuong.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (19, 4, N'Xíu mại', N'Bánh mì Việt Nam giòn thơm, với nhân thịt viên hấp dẫn, phủ thêm một lớp nước sốt cà chua ngọt, cùng với rau tươi và gia vị đậm đà.', 19000.0000, N'xiu-mai.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (20, 4, N'Gà Xé Nước Tương', N'Bánh mì Việt Nam giòn thơm với nhân gà xé, rau, gia vị hòa quyện cùng nước sốt đặc biệt.', 19000.0000, N'ga-xe-nuoc-tuong.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (21, 4, N'Chả lụa xá xíu', N'Bánh mì Việt Nam giòn thơm với chả lụa và thịt xá xíu thơm ngon, kết hợp cùng rau và gia vị, hòa quyện cùng nước sốt độc đáo.', 19000.0000, N'cha-lua-xa-xiu.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (22, 5, N'Bánh Mousse Cacao', N'Bánh Mousse Ca Cao, là sự kết hợp giữa ca-cao Việt Nam đậm đà cùng kem tươi.', 29000.0000, N'banh-mousse-cacao.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (23, 5, N'Bánh Sô-cô-la Highlands', N'Một chiếc bánh độc đáo! Sô cô la ngọt ngào và kem tươi béo ngậy, được phủ thêm một lớp sô cô la mỏng bên trên cho thêm phần hấp dẫn.', 29000.0000, N'banh-socola-highlands.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (24, 5, N'Bánh Caramel Phô Mai', N'Ngon khó cưỡng! Bánh phô mai thơm béo được phủ bằng lớp caramel ngọt ngào', 29000.0000, N'banh-caramel-pho-mai.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (25, 5, N'Bánh Mousse Đào', N'Một sự kết hợp khéo léo giữa kem và lớp bánh mềm, được phủ lên trên vài lát đào ngon tuyệt.', 29000.0000, N'banh-mousse-dao.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (26, 5, N'Bánh Phô Mai Chanh Dây', N'Vị béo của phô mai cùng với vị chua của chanh dây, tạo nên chiếc bánh thơm ngon hấp dẫn!', 29000.0000, N'banh-pho-mai-chanh-day.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (27, 5, N'Bánh Phô Mai Trà Xanh', N'Một sự sáng tạo mới mẻ, kết hợp giữa trà xanh đậm đà và phô mai ít béo.', 29000.0000, N'banh-pho-mai-tra-xanh.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (28, 5, N'Bánh Tiramisu', N'Tiramisu thơm béo, làm từ ca-cao Việt Nam đậm đà, kết hợp với phô mai ít béo, vani và chút rum nhẹ nhàng.', 19000.0000, N'banh-tiramisu.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (29, 5, N'Bánh chuối', N'Bánh chuối truyền thống, sự kết hợp của 100% chuối tươi và nước cốt dừa Việt Nam.', 19000.0000, N'banh-chuoi.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (30, 5, N'Bánh Phô Mai Cà Phê', N'Làm từ cà phê truyền thống của Highlands, kết hợp với phô mai thơm ngon! Chiếc bánh phù hợp đi cùng với bất cứ món cà phê nào!', 29000.0000, N'banh-pho-mai-ca-phe.jpg', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (31, 5, N'Phin Inox', N'Biểu tượng của Văn hóa cà phê Việt Nam! Dành cho những tín đồ cà phê thực thụ.', 79000.0000, N'phin-inox.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (32, 5, N'ly sứ mosaic', N'Việt Nam tươi đẹp qua góc nhìn của Highlands Coffee, được chế tác trên những mẫu ly sứ theo nghệ thuật ghép mảnh (khảm) cầu kỳ và phức tạp. ', 149000.0000, N'ly-su-mosaic.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (33, 5, N'Truyền thống 200gr', N'Cà phê truyền thống độc quyền của Highlands! Những hạt cà phê Robusta và Arabica thượng hạng trồng ở vùng cao nguyên của Việt Nam được rang và phối trộn theo công thức độc đáo tại Highlands.', 47000.0000, N'truyen-thong-200gr.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (34, 5, N'Truyền Thống 1KG', N'Cà phê truyền thống độc quyền của Highlands! Những hạt cà phê Robusta và Arabica thượng hạng trồng ở vùng cao nguyên của Việt Nam được rang và phối trộn theo công thức độc đáo tại Highlands.', 235000.0000, N'truyen-thong-1kg.png', 50)
INSERT [dbo].[ThucDon] ([MaMon], [MaLoaiMon], [TenMon], [MoTa], [Gia], [Hinh], [SoLuong]) VALUES (45, 1, N'PHIN ĐEN ĐÁ', N'Dành cho những tín đồ cà phê đích thực! Hương vị cà phê truyền thống được phối trộn độc đáo tại Highlands. Cà phê đậm đà pha hoàn toàn từ Phin, cho thêm 1 thìa đường, một ít đá viên mát lạnh, tạo nên Phin Đen Đá mang vị cà phê đậm đà chất Phin.', 29000.0000, N'phin-den-da.png', 50)
SET IDENTITY_INSERT [dbo].[ThucDon] OFF
SET IDENTITY_INSERT [dbo].[TinTuc] ON 

INSERT [dbo].[TinTuc] ([MaTin], [TieuDe], [NoiDung], [AnhTinTuc], [NgayDang]) VALUES (1, N'ĐẠI TIỆC ÂM NHẠC: HIGHLANDS COFFEE 20 NĂM - GẮN KẾT NIỀM TỰ HÀO ĐẤT VIỆT', N'Nằm trong chương trình “20 năm – Gắn kết niềm tự hào đất Việt”, lần đầu tiên, Highlands Coffee sẽ đưa hàng nghìn người hâm mộ đến với chuỗi sự kiện âm nhạc sôi động cùng hàng loạt trải nghiệm độc đáo diễn ra tại những địa điểm mang tính biểu tượng của ba thành phố lớn Đà Nẵng (08/11), Thủ đô Hà Nội (16/11) và Tp. Hồ Chí Minh (23/11).Highlands Coffee với niềm tự hào đất Việt đã trở thành cầu nối gắn kết các đối tác, đội ngũ nhân viên và đặc biệt là hàng triệu khách hàng thân thiết trong suốt chặng đường 20 năm đầy cảm hứng. Đánh dấu mốc kỉ niệm “tuổi 20” đầy ý nghĩa này, Highlands Coffee triển khai chương trình “20 năm – Gắn kết niềm tự hào đất Việt” mong muốn gửi đến những người đồng hành, triệu khách hàng thân thiết lời cảm ơn chân thành nhất, đồng thời thể hiện khát vọng được viết tiếp những chương mới cho câu chuyện gắn kết niềm tự hào đất Việt. Và để lan toả thông điệp tới công chúng, Highlands Coffee sẽ tổ chức chuỗi sự kiện âm nhạc hoành tráng in đậm dấu ấn từ sự hoà quyện giữa truyền thống và hiện đại, diễn ra ở những địa điểm mang tính biểu trưng của 3 thành phố Đà Nẵng, Hà Nội và Tp. Hồ Chí Minh sẽ mang những lời tri ân chân thành từ Highlands Coffee lan toả mạnh mẽ hơn đến triệu trái tim Việt để câu chuyện về “Niềm tự hào đất Việt” một lần nữa được thắp lên đầy hào hùng.', N'tin1.jpg', CAST(0x4F400B00 AS Date))
INSERT [dbo].[TinTuc] ([MaTin], [TieuDe], [NoiDung], [AnhTinTuc], [NgayDang]) VALUES (2, N'HIGHLANDS COFFEE: TRỌN VẸN TUỔI 20 CÙNG HÀNH TRÌNH GẮN KẾT “NIỀM TỰ HÀO ĐẤT VIỆT”', N'Miệt mài lan tỏa “niềm tự hào đất Việt” trong suốt 20 năm, một Highlands Coffee trẻ trung, nhưng cũng thật trưởng thành đã hiện lên một cách đầy cảm hứng qua ca khúc được sáng tác độc quyền mừng cột mốc “tuổi 20” của chuỗi cà phê mang đậm bản sắc Việt.Bắt đầu bằng giai điệu tươi vui khơi nguồn cho niềm tự hào đất Việt, hình ảnh Highlands Coffee hiện ra đầy chân thực, đan xen mượt mà với từng cột mốc đáng nhớ trong suốt 20 năm. Người xem sẽ dễ dàng bắt gặp trong từng thước phim những hình ảnh dung dị mà cũng đầy tự hào của người Việt trên khắp mọi miền.Hòa mình theo từng giai điệu, khung hình trong MV “20 năm - Gắn kết niềm tự hào đất Việt” của Highlands Coffee, người xem như được hóa thân thành những người nông dân “tự hào vun vén mầm xanh”, nuôi dưỡng và chờ ngày thu hoạch từng hạt cafe chín mọng, từng lá trà tươi xanh nơi cao nguyên đầy nắng gió hay chàng bartista đang “từng ngày gìn giữ, sẻ chia những yêu thương” qua mỗi ly café, ly trà trao tay khách. Theo chân những con người Highlands Coffee tràn đầy nhiệt huyết và đam mê này, ta nhìn thấy cả một chặng đường 20 năm của Highlands Coffee từ buổi đầu xây dựng “văn hóa café Việt” đến khi “niềm tự hào đất Việt” đã được lan tỏa rộng khắp. Những thước phim mượt mà nhắc nhớ người xem về những tháng ngày miệt mài tìm đến từng đối tác, từng vườn café, từng đồi chè để đổi lấy những cái bắt tay cùng chung chí hướng, những cái gật đầu đầy tin cậy. Để rồi nhường chỗ cho “từng ngày mới thêm ngọt ngào, cảm xúc dâng trào” khi nhớ về những kỉ niệm không thể quên cùng ly Phin Sữa Đá, ly Trà Sen Vàng hay ly Freeze Trà Xanh.', N'tin2.jpg', CAST(0x49400B00 AS Date))
INSERT [dbo].[TinTuc] ([MaTin], [TieuDe], [NoiDung], [AnhTinTuc], [NgayDang]) VALUES (4, N'TẾT SEN VÀNG, XUÂN GIÒN CHUYỆN', N'“Ly trà là đầu câu chuyện”. Để khai xuân như ý, những câu chuyện đầu năm phải thật rôm rả bên người thương yêu. Trà Sen Vàng - Rộn Ràng chuyện đầu năm', N'tin4.png', CAST(0x323F0B00 AS Date))
INSERT [dbo].[TinTuc] ([MaTin], [TieuDe], [NoiDung], [AnhTinTuc], [NgayDang]) VALUES (3, N'HIGHLANDS COFFEE: 20 NĂM – GẮN KẾT NIỀM TỰ HÀO ĐẤT VIỆT', N'Đánh dấu hành trình 20 năm gắn kết, Highlands Coffee mong muốn gửi lời cảm ơn chân thành đến các đối tác, các bạn nhân viên và những khách hàng thân thiết đã đồng hành cùng với Highlands Coffee trong suốt 20 năm qua, cùng Highlands Coffee tiếp tục lan tỏa niềm tự hào đối với những giá trị Việt. Highlands Coffee – Điểm nhấn không thể thiếu của nhiều thế hệ người Việt. Năm 1999, Highlands Coffee chính thức được thành lập, với tầm nhìn trở thành thương hiệu cà phê và trà được yêu thích nhất tại Việt Nam và tự hào chia sẻ với thế giới. Tính đến tháng 8/2019, Highlands Coffee là chuỗi cà phê có số lượng quán lớn nhất tại Việt Nam với hơn 300 quán trải dài trên khắp 24 tỉnh thành. Không ngừng đặt chân đến những vùng đất mới trên khắp cả nước, Highlands Coffee còn mang những giá trị Việt đến thế giới với chuỗi 50 quán cà phê trên thế giới.', N'tin3.jpg', CAST(0x2C3F0B00 AS Date))
INSERT [dbo].[TinTuc] ([MaTin], [TieuDe], [NoiDung], [AnhTinTuc], [NgayDang]) VALUES (5, N'TẬN HƯỞNG HƠN CÙNG SỔ KHUYẾN MÃI FREEZE TRÀ XANH', N'Từ ngày 16/07/2018 đến ngày 30/09/2018 tại Highlands Coffee® toàn quốc, Quý Khách Hàng khi mua Freeze Trà Xanh® bất kỳ kích cỡ sẽ có cơ hội nhận ngay phiếu ưu đãi với nhiều chương trình hấp dẫn cùng Freeze Trà Xanh® đậm đà, thạch giòn khó cưỡng! Để tận hưởng cuộc vui cùng bạn bè và gia đình thêm bất tận, Khi mua 01 ly Freeze Trà Xanh® bất kỳ cỡ nào, khách hàng sẽ được tặng 01 bánh ngọt miễn phí (áp dụng cho phiếu số 1). Quý khách có thể trả thêm 5,000 VNĐ để có 01 nước suối (áp dụng cho phiếu số 1)', N'tin5.png', CAST(0x713E0B00 AS Date))
SET IDENTITY_INSERT [dbo].[TinTuc] OFF
SET IDENTITY_INSERT [dbo].[TrachNhiemCongDong] ON 

INSERT [dbo].[TrachNhiemCongDong] ([MaTNCD], [TieuDe], [NoiDung], [AnhTinTuc]) VALUES (1, N'HIGHLANDS COFFEE CÙNG Ý TƯỞNG “LỒNG ĐÈN XANH” THẮP SÁNG "TRUNG THU XANH” CHO HƠN 700 EM NHỎ', N'Nhằm góp phần mang đến một mùa Trung thu ấm áp đồng thời truyền tải thông điệp ý nghĩa cùng chiến dịch “Những Cánh Tay Xanh”, đội ngũ Highlands Coffee vừa qua đã trao hàng trăm xuất quà bao gồm bánh kẹo, sách vở,…và đặc biệt là những chiếc “lồng đèn xanh” được làm hoàn toàn từ nhựa tái sử dụng đến với hơn 700 trẻ em tại các vùng khó khăn tại Bắc Giang, Bến Tre và tại Bệnh viện Ung bướu Tp. Hồ Chí Minh.', N'Trachnhiem1.png')
INSERT [dbo].[TrachNhiemCongDong] ([MaTNCD], [TieuDe], [NoiDung], [AnhTinTuc]) VALUES (2, N'ĐƯƠNG ĐẠI HÓA TRANH ĐÔNG HỒ!', N'Tranh Đông Hồ thể hiện sự gần gũi với đời sống sinh hoạt thường ngày của dân gian. Và đặc biệt vào mỗi dịp Tết xưa, những bức tranh Đông Hồ Chúc Tụng mang màu sắc tươi sáng được trang trí trong mỗi gia đình làm không khí ngày xuân thêm phần rực rỡ, ấm cúng. Mang một tình yêu bất tận với nền văn hóa Việt Nam, chúng tôi mong muốn truyền thống văn hóa nghệ thuật của đất nước được giữ gìn và phát triển. Bởi đó không chỉ là bản sắc lịch sử của dân tộc mà còn là hiện thân của đất nước qua các thời đại. Liên hệ với nghệ nhân Nguyễn Đăng Chế - một trong 2 nghệ nhân Đông Hồ duy nhất còn lại của Việt Nam, Bác Chế đã cùng chúng tôi kết nối với nhiều hoạ sĩ trẻ và chia sẻ những nỗi niềm, tâm nguyện của mình đến các bạn. Từ đó, truyền cảm hứng để các bạn thổi hồn hơi thở người trẻ hiện đại vào nghệ thuật Đông Hồ. Bằng sự kết hợp sáng tạo và sức sống hiện đại của tuổi trẻ vào nét nghệ thuật của truyền thống văn hóa dân gian trên 13 bức tranh Đông Hồ Kinh Điển chúc tụng ngày Tết, một bộ tranh “ĐƯƠNG ĐẠI HÓA TRANH ĐÔNG HỒ” đầy ý nghĩa – thể hiện các thông điệp chúc phúc cho một năm mới tràn đầy “Sức khỏe – Thịnh vượng – Hạnh phúc” đã được trình làng đến giới trẻ. Bộ tranh được thực hiện bởi 3 hoạ sĩ trẻ: Phạm Quang Phúc, Nguyễn Thị Phương Trinh và Phạm Rồng. Hãy cùng Highlands Coffee chiêm ngưỡng 13 bức tranh đầy tâm huyết này và khám phá ý nghĩa đằng sau mỗi bức tranh nhé!', N'Trachnhiem2.png')
INSERT [dbo].[TrachNhiemCongDong] ([MaTNCD], [TieuDe], [NoiDung], [AnhTinTuc]) VALUES (3, N'TRUNG THU YÊU THƯƠNG - LỚP HỌC CHO EM 2017', N'Mùa trăng năm nay, Highlands Coffee đã tổ chức Chương trình "TRUNG THU YÊU THƯƠNG" vào ngày 01/10/2017. Với tiêu điểm là ''''Trung Thu yêu thương và Lễ khởi công Lớp học cho em năm 2017” được tổ chức tại trường Tiểu học Lam Sơn, điểm Đồi Trường, Xã Thanh Sơn – Huyện Định Quán – Tỉnh Đồng Nai.

Ở đó có những hoàn cảnh rất khó khăn kéo theo đó là những em nhỏ không đủ về điều kiện học tập lẫn đủ đầy về kí ức tuổi thơ. Chương trình phần nào khẳng định: “Trên con đường đi đến thành công, đến bến bờ vinh quang, Highlands Coffee không chỉ là nơi cho mỗi cá nhân trưởng thành trong sự nghiệp mỗi người mà còn là nơi tình yêu thương được nhân rộng và chia sẻ”.

Chúng ta hãy cùng nhìn lại hành trình thiện nguyện mang “Trung thu yêu thương” và khởi động dự án “Lớp học cho em” qua các hình ảnh để hiểu hơn về chặng đường tạo điều kiện tốt hơn cho hành trình tìm con chữ của các em nhỏ miền ngược mà chúng ta đang làm.', N'Trachnhiem3.png')
SET IDENTITY_INSERT [dbo].[TrachNhiemCongDong] OFF
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETDONHANG] FOREIGN KEY([MaDonHang])
REFERENCES [dbo].[DonDatHang] ([MaDonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CHITIETDONHANG]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETDONHANG_MaMon] FOREIGN KEY([MaMon])
REFERENCES [dbo].[ThucDon] ([MaMon])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CHITIETDONHANG_MaMon]
GO
ALTER TABLE [dbo].[DonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_DonDatHang_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonDatHang] CHECK CONSTRAINT [FK_DonDatHang_KhachHang]
GO
ALTER TABLE [dbo].[ThucDon]  WITH CHECK ADD  CONSTRAINT [FK_MaLoaiMon] FOREIGN KEY([MaLoaiMon])
REFERENCES [dbo].[LoaiMon] ([MaLoaiMon])
GO
ALTER TABLE [dbo].[ThucDon] CHECK CONSTRAINT [FK_MaLoaiMon]
GO
USE [master]
GO
ALTER DATABASE [COFFE_HIGHLAND1] SET  READ_WRITE 
GO
