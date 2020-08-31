using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CoffeeShop.Models;
namespace CoffeeShop.Controllers
{
    public class GioHangController : Controller
    {
        //
        // GET: /GioHang/
        DataClasses1DataContext data = new DataClasses1DataContext();

        //lay gio hang
        public List<GioHang> LayGioHang()
        {

            List<GioHang> listGioHang = Session["GioHang"] as List<GioHang>;
            if (listGioHang == null)
            {
                listGioHang = new List<GioHang>();
                Session["GioHang"] = listGioHang;
            }

            return listGioHang;
        }

        public ActionResult ThemGioHang(int MaMon, String strUrl)
        {
            //Lay Session Gio Hang
            List<GioHang> listgiohang = LayGioHang();
            GioHang sanpham = listgiohang.Find(a => a.maMon == MaMon);
            if (sanpham == null)
            {
                sanpham = new GioHang(MaMon);
                listgiohang.Add(sanpham);
                return Redirect(strUrl);
            }
            else
            {
                sanpham.soLuong++;
                return Redirect(strUrl);
            }
        }
        private int TongSoLuong()
        {
            int TongSl = 0;
            List<GioHang> listgiohang = Session["GioHang"] as List<GioHang>;
            if (listgiohang != null)
            {
                TongSl = listgiohang.Sum(n => n.soLuong);

            }
            return TongSl;
        }
        private double TongTien()
        {
            double tongtien = 0;
            List<GioHang> listgiohang = Session["GioHang"] as List<GioHang>;
            if (listgiohang != null)
            {
                tongtien = listgiohang.Sum(n => n.thanhTien);
            }

            return tongtien;
        }
        //xay dung trang gio hang
        public ActionResult GioHang()
        {
            List<GioHang> listgiohang = LayGioHang();
            if (listgiohang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return View(listgiohang);
        }
        //PartialView  giỏ hàng
        public ActionResult ThongTinGioHang()
        {
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return PartialView();
        }
        //xoa gio hang
        public ActionResult XoaGioHang(int MaMon)
        {
            List<GioHang> listgiohang = LayGioHang();
            GioHang sanpham = listgiohang.SingleOrDefault(a => a.maMon == MaMon);
            if (sanpham != null)
            {
                listgiohang.RemoveAll(a => a.maMon == MaMon);
                return RedirectToAction("GioHang");
            }
            if (listgiohang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("GioHang");
        }
        //Cap Nhap Gio Hang ?
        public ActionResult CapNhapGioHang(int MaMon, FormCollection f)
        {
            //Lay Gio Hang Tu Session
            List<GioHang> lstGioHang = LayGioHang();
            GioHang sp = lstGioHang.SingleOrDefault(n => n.maMon == MaMon);
            if (sp != null)
            {
                sp.soLuong = int.Parse(f["txtSoLuong"].ToString());
            }
            return Redirect("GioHang");
        }

        //Xoa Tat Ca Gio Hang
        public ActionResult XoaTatCaGioHang()
        {
            List<GioHang> lstGioHang = LayGioHang();
            lstGioHang.Clear();
            return RedirectToAction("Index", "Home");

        }
        public ActionResult DatHang()
        {
            if (Request.Cookies["TaiKhoan"] == null || Session["GioHang"].ToString()==null)
            {
                return RedirectToAction("DangNhap", "NguoiDung");
            }
            if (Session["GioHang"]== null)
            {
                return RedirectToAction("Index", "Home");
            }
            List<GioHang> listgiohang = LayGioHang();
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return View(listgiohang);
        }
        public ActionResult ThongTinDatHang()
        {
            return PartialView();
        }
        [HttpPost]
        public ActionResult DatHang(FormCollection f)
        {
            DonDatHang ddh = new DonDatHang();
            KhachHang kh = (KhachHang)Session["TaiKhoanq"];
            List<GioHang> listGioHang = LayGioHang();

            ddh.MaKH = kh.MaKH;
            var NgayGiao = string.Format("{0:MM/dd/yyyy}", f["NgayGiao"]);
                ddh.NgayGiao = DateTime.Parse(NgayGiao);
            ddh.NgayDat = DateTime.Now;
            ddh.TinhTrangGiaoHang = false;
            ddh.DaThanhToan = false;

            data.DonDatHangs.InsertOnSubmit(ddh);
            data.SubmitChanges();

            foreach (var item in listGioHang)
            {
                ChiTietDonHang ct = new ChiTietDonHang();
                ct.MaDonHang = ddh.MaDonHang;
                ct.MaMon = item.maMon;
                ct.SoLuong = item.soLuong;
                ct.Dongia = (decimal)item.donGia;
                data.ChiTietDonHangs.InsertOnSubmit(ct);
            }

            data.SubmitChanges();
            Session["GioHang"] = null;
            return RedirectToAction("XacNhanDonDatHang", "GioHang");
        }
        public ActionResult XacNhanDonDatHang()
        {
            return View();
        }
    }
}
