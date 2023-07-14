
package clases;


public class Supervisor {
    private int supervisorId;
    private String nombreSup;
    private String apellidoSup;
    
    public Supervisor() {
        this.supervisorId = 0;
        this.nombreSup = "";
        this.apellidoSup = "";
    }

    public int getSupervisorId() {
        return supervisorId;
    }

    public void setSupervisorId(int supervisorId) {
        this.supervisorId = supervisorId;
    }

    
    
    public String getNombreSup() {
        return nombreSup;
    }

    public void setNombreSup(String nombreSup) {
        this.nombreSup = nombreSup;
    }

    public String getApellidoSup() {
        return apellidoSup;
    }

    public void setApellidoSup(String apellidoSup) {
        this.apellidoSup = apellidoSup;
    }
    
    
    
    
    
    
    
}
