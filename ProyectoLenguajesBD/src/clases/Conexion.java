package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//Patron Singleton 

public class Conexion {

    private static Conexion instancia;
    private static Connection conexion;
    private static final String url = "jdbc:oracle:thin:@//localhost:1521/xe";
    private static final String usuario = "C##ProyectoFinal";
    private static final String contra = "123";

    private Conexion() {

    }

    public Connection conectar() {
        try {
            conexion = DriverManager.getConnection(url, usuario, contra);
            System.out.println("Conexion Exitosa");
        } catch (SQLException ex) {
            System.out.println("Error al conectar: " + ex);
        }
        return conexion;
    }

    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException ex) {
            System.out.println("Error al desconectar: " + ex);
        }
    }

    public static Conexion getInstancia() {
        if (instancia == null) {
            instancia = new Conexion();
        }
        return instancia;
    }
}
