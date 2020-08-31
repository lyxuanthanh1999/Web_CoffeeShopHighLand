using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CoffeeShop.Models;
namespace CoffeeShop.Controllers
{
    public class NguoiDungController : Controller
    {
        //
        // GET: /NguoiDung/

        public ActionResult Index()
        {
            return View();
        }
        DataClasses1DataContext data = new DataClasses1DataContext();
        bool compare(string s1, string s2)
        {
            if (s1.Equals(s2))
            {
                return true;
            }
            return false;
        }
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection f)
        {
            var tendn = f["tendn"];
            var matkhau = f["matkhau"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Tên Đăng Nhập Không Được Để Trống";
            }
            else
            {
                if (string.IsNullOrEmpty(matkhau))
                {
                    ViewData["Loi2"] = "Mật khẩu Không Được Để Trống";
                }
                else
                {
                    KhachHang kh = data.KhachHangs.SingleOrDefault(n => n.TaiKhoan == tendn && n.MatKhau == matkhau);
                    if (kh != null)
                    {
                        Session["TaiKhoanq"] = kh;
                        HttpCookie cookie = new HttpCookie("TaiKhoan");
                        cookie.Value = kh.TaiKhoan;
                        cookie.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(cookie);
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ViewBag.ThongBao = "Tên Đăng Nhập và Mật Khẩu không đúng !!!";
                    }
                }
            }
            return this.DangNhap();
        }
        public ActionResult Log()
        {
            HttpCookie cookie = new HttpCookie("TaiKhoan");
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);
            return RedirectToAction("Index", "Home");
        }
        public ActionResult DangKy()
        {
            return View();
        }
        public bool ktTonTai(string user)
        {

            var timKiemTen = data.KhachHangs.Where(a => a.TaiKhoan == user).SingleOrDefault();
            if (timKiemTen != null)
            {
                return false;
            }
            return true;
        }
        [HttpPost]
        public ActionResult DangKy(FormCollection f, KhachHang kh)
        {
            var tenkh = f["HoTenKH"];
            var tendn = f["TenDN"];
            var matkhau = f["MatKhau"];
            var matkhaunhaplai = f["MatKhauNhapLai"];
            var diachi = f["DiaChi"];
            var email = f["Email"];
            var dienthoai = f["DienThoai"];
            var ngaysinh = f["NgaySinh"].ToString();
            if (string.IsNullOrEmpty(tenkh))
            {
                @ViewData["Loi1"] = "Họ Tên Khách Hàng Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(tendn))
            {
                @ViewData["Loi2"] = "Tên Đăng Nhập Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(matkhau))
            {
                @ViewData["Loi3"] = "Mật khẩu Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(matkhaunhaplai))
            {
                @ViewData["Loi4"] = "Mật Khẩu Nhập Lại Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(email))
            {
                @ViewData["Loi5"] = "Địa Chỉ Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(dienthoai))
            {
                @ViewData["Loi6"] = "Điện Thoại Không Được Để Trống";
            }
            if (string.IsNullOrEmpty(ngaysinh))
            {
                @ViewData["date"] = "Ngày Sinh hãy nhập vào";
            }
            if (compare(matkhau, matkhaunhaplai) == true && ktTonTai(tendn) == true)
            {
                kh.HoTen = tenkh;
                kh.TaiKhoan = tendn;
                kh.MatKhau = matkhau;
                kh.Email = email;
                kh.DienThoai = dienthoai;
                kh.DiaChi = diachi;
                kh.NgaySinh = DateTime.Parse(ngaysinh);
                data.KhachHangs.InsertOnSubmit(kh);
                data.SubmitChanges();
                return RedirectToAction("DangNhap");

            }


            @ViewData["ThongBao"] = "Đăng Ký Thất Bại";

            return this.DangKy();
        }
    }
}
