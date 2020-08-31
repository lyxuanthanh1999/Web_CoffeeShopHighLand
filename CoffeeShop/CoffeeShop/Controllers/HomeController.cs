using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CoffeeShop.Models;
using PagedList;
using PagedList.Mvc;
using System.Net;
namespace CoffeeShop.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        DataClasses1DataContext data = new DataClasses1DataContext();


        public ActionResult Index()
        {
            return View();
        }
        private List<LoaiMon> LayLoaiMonAn()
        {
            return data.LoaiMons.ToList();
        }
        public ActionResult ThucDon()
        {

            var ds = LayLoaiMonAn();
            return View(ds);
        }

        public ActionResult MonCoMaLoai(int id)
        {
            var ds = from MCML in data.ThucDons.Where(a => a.MaLoaiMon == id) select MCML;
            return View(ds);
        }
        string id1;

        //[HttpPost]
        //public ActionResult SanPhamLienQuan(FormCollection f)
        //{
        //    id1 = f["mlm"];
        //    List<ThucDon> lstsp = data.ThucDons.Where(a => a.MaLoaiMon == int.Parse(id1)).Distinct().Take(5).ToList();
        //    return PartialView(lstsp);
        //}

        public ActionResult SanPhamLienQuan2(String maLoai)
        {
            int maLoaiSP = int.Parse(maLoai);
            List<ThucDon> lstsp = data.ThucDons.Where(a => a.MaLoaiMon == maLoaiSP).Distinct().ToList();
            return PartialView(lstsp);
        }






        public ActionResult DetailMon(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var td = data.ThucDons.Where(a => a.MaMon == id).First();
            
            return View(td);
        }




        private List<TinTuc> LayTinTuc()
        {
            return data.TinTucs.ToList();
        }
        public ActionResult TinTuc()
        {
            var tintuc = LayTinTuc();
            return View(tintuc);
        }
        public ActionResult DetailTinTuc(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var dttt = data.TinTucs.Where(a => a.MaTin == id).First();
            return View(dttt);
        }



        private List<TrachNhiemCongDong> layListTNCD()
        {
            return data.TrachNhiemCongDongs.ToList();
        }
        public ActionResult TrachNhiemCongDong()
        {
            var TNCD = layListTNCD();
            return View(TNCD);
        }
        public ActionResult DetailTrachNhiemCongDong(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var dtTNCD = data.TrachNhiemCongDongs.Where(a => a.MaTNCD == id).First();
            return View(dtTNCD);
        }
    }
}
