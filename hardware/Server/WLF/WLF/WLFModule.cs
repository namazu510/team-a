using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WLF
{
    class WLFModule
    {
        public DateTime start { set; get; }
        public DateTime end { set; get; }
        public uint step { set; get; }

        private static String userid = "";
        private static String passwd = "";

        public static void setUserProfile(String id,String pw)
        {
            userid = id;
            passwd = pw;
        }

        public static Boolean isLogin()
        {
            return userid.Length>0 && passwd.Length > 0;
        }

        public void execute()
        {
            string url = "http://localhost:58306/exercise_logs";
            try
            {
                System.Net.WebClient wc = new System.Net.WebClient();
                System.Collections.Specialized.NameValueCollection data =
                    new System.Collections.Specialized.NameValueCollection();
                data.Add("user_id", userid);
                data.Add("password", passwd);
                data.Add("start_time", start.ToString());
                data.Add("end_time", end.ToString());
                data.Add("step_cnt", step.ToString());
                wc.UploadValues(url, data);
                wc.Dispose();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
}
