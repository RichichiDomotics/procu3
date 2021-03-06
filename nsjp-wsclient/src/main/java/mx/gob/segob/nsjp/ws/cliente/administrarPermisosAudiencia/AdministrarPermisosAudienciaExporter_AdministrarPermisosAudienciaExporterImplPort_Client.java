
package mx.gob.segob.nsjp.ws.cliente.administrarPermisosAudiencia;

/**
 * Please modify this class to meet your needs
 * This class is not complete
 */

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.namespace.QName;

/**
 * This class was generated by Apache CXF 2.4.1
 * 2012-06-18T17:25:05.917-05:00
 * Generated source version: 2.4.1
 * 
 */
public final class AdministrarPermisosAudienciaExporter_AdministrarPermisosAudienciaExporterImplPort_Client {

    private static final QName SERVICE_NAME = new QName("http://impl.ws.service.nsjp.segob.gob.mx/", "AdministrarPermisosAudienciaExporterImplService");

    private AdministrarPermisosAudienciaExporter_AdministrarPermisosAudienciaExporterImplPort_Client() {
    }

    public static void main(String args[]) throws java.lang.Exception {
        URL wsdlURL = AdministrarPermisosAudienciaExporterImplService.WSDL_LOCATION;
        if (args.length > 0 && args[0] != null && !"".equals(args[0])) { 
            File wsdlFile = new File(args[0]);
            try {
                if (wsdlFile.exists()) {
                    wsdlURL = wsdlFile.toURI().toURL();
                } else {
                    wsdlURL = new URL(args[0]);
                }
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        }
      
        AdministrarPermisosAudienciaExporterImplService ss = new AdministrarPermisosAudienciaExporterImplService(wsdlURL, SERVICE_NAME);
        AdministrarPermisosAudienciaExporter port = ss.getAdministrarPermisosAudienciaExporterImplPort();  
        
        {
        System.out.println("Invoking consultarPermisoAudienciaUsuarioExterno...");
        mx.gob.segob.nsjp.ws.cliente.administrarPermisosAudiencia.FuncionarioExternoWSDTO _consultarPermisoAudienciaUsuarioExterno_arg0 = null;
        try {
            mx.gob.segob.nsjp.ws.cliente.administrarPermisosAudiencia.AudienciaJAVSTransporteWSDTO _consultarPermisoAudienciaUsuarioExterno__return = port.consultarPermisoAudienciaUsuarioExterno(_consultarPermisoAudienciaUsuarioExterno_arg0);
            System.out.println("consultarPermisoAudienciaUsuarioExterno.result=" + _consultarPermisoAudienciaUsuarioExterno__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }
        {
        System.out.println("Invoking consultarParametrosConsultaAudienciaJavs...");
        java.lang.Long _consultarParametrosConsultaAudienciaJavs_arg0 = null;
        try {
            mx.gob.segob.nsjp.ws.cliente.administrarPermisosAudiencia.AudienciaJAVSTransporteWSDTO _consultarParametrosConsultaAudienciaJavs__return = port.consultarParametrosConsultaAudienciaJavs(_consultarParametrosConsultaAudienciaJavs_arg0);
            System.out.println("consultarParametrosConsultaAudienciaJavs.result=" + _consultarParametrosConsultaAudienciaJavs__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }
        {
        System.out.println("Invoking consultarDirectoriosConsultaJAVS...");
        java.lang.Long _consultarDirectoriosConsultaJAVS_arg0 = null;
        try {
            byte[] _consultarDirectoriosConsultaJAVS__return = port.consultarDirectoriosConsultaJAVS(_consultarDirectoriosConsultaJAVS_arg0);
            System.out.println("consultarDirectoriosConsultaJAVS.result=" + _consultarDirectoriosConsultaJAVS__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }
        {
        System.out.println("Invoking consultarRegistroMaestroJVL...");
        java.lang.Long _consultarRegistroMaestroJVL_arg0 = null;
        try {
            byte[] _consultarRegistroMaestroJVL__return = port.consultarRegistroMaestroJVL(_consultarRegistroMaestroJVL_arg0);
            System.out.println("consultarRegistroMaestroJVL.result=" + _consultarRegistroMaestroJVL__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }
        {
        System.out.println("Invoking datosConexion...");
        java.lang.Long _datosConexion_arg0 = null;
        try {
            java.lang.String _datosConexion__return = port.datosConexion(_datosConexion_arg0);
            System.out.println("datosConexion.result=" + _datosConexion__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }
        {
        System.out.println("Invoking generarPermisoUsuarioExterno...");
        mx.gob.segob.nsjp.ws.cliente.administrarPermisosAudiencia.FuncionarioExternoWSDTO _generarPermisoUsuarioExterno_arg0 = null;
        try {
            java.lang.Long _generarPermisoUsuarioExterno__return = port.generarPermisoUsuarioExterno(_generarPermisoUsuarioExterno_arg0);
            System.out.println("generarPermisoUsuarioExterno.result=" + _generarPermisoUsuarioExterno__return);

        } catch (NSJPNegocioException_Exception e) { 
            System.out.println("Expected exception: NSJPNegocioException has occurred.");
            System.out.println(e.toString());
        }
            }

        System.exit(0);
    }

}
