using System;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Linq;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminInformes : Page
    {
        protected global::System.Web.UI.WebControls.Button btnDescargarFinanciero;
        protected global::System.Web.UI.WebControls.Button btnDescargarUsuarios;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnDescargarFinanciero_Click(object sender, EventArgs e)
        {
            var cadContratos = new CADContrato();
            var cadUsuarios = new CADUsuario();
            var contratos = cadContratos.ListarTodos();
            
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("=== REPORTE FINANCIERO CONVIAPP ===");
            sb.AppendLine("Fecha de generación: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
            sb.AppendLine("---------------------------------------------------------");

            var contratosPorUsuario = contratos.GroupBy(c => c.UserId);
            decimal totalIngresosGlobales = 0;

            foreach (var group in contratosPorUsuario)
            {
                var usuario = cadUsuarios.LeerUsuario(group.Key);
                string email = usuario != null ? usuario.Email : "Usuario Desconocido";
                
                decimal totalInvertido = group.Sum(c => c.TotalContractValue());
                totalIngresosGlobales += totalInvertido;

                sb.AppendLine($"ID Usuario: {group.Key} | Email: {email}");
                sb.AppendLine($"Contratos Activos: {group.Count()} | Total Invertido: {totalInvertido:C}");
                sb.AppendLine("---------------------------------------------------------");
            }

            sb.AppendLine($"INGRESOS TOTALES PROYECTADOS: {totalIngresosGlobales:C}");

            Response.Clear();
            Response.ContentType = "text/plain";
            Response.AddHeader("content-disposition", "attachment;filename=Reporte_Financiero.txt");
            Response.Write(sb.ToString());
            Response.End();
        }

        protected void btnDescargarUsuarios_Click(object sender, EventArgs e)
        {
            var cadUsuarios = new CADUsuario();
            var usuarios = cadUsuarios.ObtenerTodos();
            var cadInc = new CADIncidencia();
            var todasInc = cadInc.ListarTodas();
            var cadGasto = new CADGasto();
            var todosGastos = cadGasto.ListarTodos();

            var sb = new StringBuilder();
            sb.AppendLine("=== REPORTE COMPLETO DE USUARIOS — CONVIAPP ===");
            sb.AppendLine("Fecha: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
            sb.AppendLine("Total usuarios registrados: " + usuarios.Count);
            sb.AppendLine(new string('=', 60));

            foreach (var u in usuarios)
            {
                sb.AppendLine($"\nID: {u.Id}");
                sb.AppendLine($"Nombre: {u.Nombre} {u.Apellidos}");
                sb.AppendLine($"Email: {u.Email}");
                sb.AppendLine($"Plan: {(u.Rol != null ? u.Rol.Nombre : "Basico")}");
                sb.AppendLine($"Activo: {(u.Activo ? "Sí" : "No")}");
                sb.AppendLine($"Fecha registro: {u.FechaRegistro:dd/MM/yyyy}");
                int numInc = todasInc.Count(i => i.ReportadaPorId == u.Id);
                decimal totalGastos = todosGastos.Where(g => g.RegistradoPorId == u.Id).Sum(g => g.Importe);
                sb.AppendLine($"Incidencias creadas: {numInc}");
                sb.AppendLine($"Total gastos registrados: {totalGastos:C}");
                sb.AppendLine(new string('-', 40));
            }

            Response.Clear();
            Response.ContentType = "text/plain";
            Response.AddHeader("content-disposition", "attachment;filename=Usuarios_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".txt");
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}
