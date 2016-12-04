package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Registro;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RegistroDAO extends BaseDAO{
	
    private static RegistroDAO singleton;
    private static Logger LOGGER = Logger.getLogger(RegistroDAO.class.getName());

    public static RegistroDAO getInstance() {
        if (singleton == null) {
            singleton = new RegistroDAO();
        }
        return singleton;
    }
	
	public void inserir(Registro registro) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO registro_reg(reg_codpes, reg_codvcn, reg_codcon, reg_dtvacina, "
	    		+ "reg_dtvalidade, reg_lote, reg_dose) VALUES(?,?,?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setInt(1, registro.getPessoa().getCodigo());
	        pstmt.setInt(2, registro.getVacina().getCodigo());
	        pstmt.setInt(3, registro.getConsulta().getCodigo());
	        pstmt.setDate(4, (Date) registro.getDataVacina());
	        pstmt.setDate(5, (Date) registro.getDataValidade());
	        pstmt.setString(6, registro.getLote());
	        pstmt.setInt(7, registro.getDose());

	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria novo registro";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Registro registro) throws DAOException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE registro_reg SET reg_codpes = ?, reg_codvcn = ?, reg_codcon = ?, "
	    		+ "reg_dtvacina = ?, reg_dtvalidade = ?, reg_lote = ?, reg_dose = ? WHERE reg_codreg = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setInt(1, registro.getPessoa().getCodigo());
	        pstmt.setInt(2, registro.getVacina().getCodigo());
	        pstmt.setInt(3, registro.getConsulta().getCodigo());
	        pstmt.setDate(4, (Date) registro.getDataVacina());
	        pstmt.setDate(5, (Date) registro.getDataValidade());
	        pstmt.setString(6, registro.getLote());
	        pstmt.setInt(7, registro.getDose());
	        pstmt.setInt(8, registro.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria altera��es no registro (" + registro.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Registro> carregarTodos() throws DAOException {
		List<Registro> registros = new ArrayList<Registro>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from registro_reg order by reg_codreg";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Registro registro = gerarRegistro(res);
                registros.add(registro);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas os registros";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return registros;
	}
	
	public Registro carregarPorCodigo(Integer codigo) throws DAOException {
		Registro registro = new Registro();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM registro_reg WHERE reg_codreg = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	registro = gerarRegistro(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava o registro (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return registro;
	}

	private Registro gerarRegistro(ResultSet res) throws SQLException, DAOException {
		Registro registro = new Registro();
		
		registro.setCodigo(res.getInt("reg_codreg"));
		registro.setPessoa(PessoaDAO.getInstance().carregarPorCodigo(res.getInt("reg_codpes")));
		registro.setVacina(VacinaDAO.getInstance().carregarPorCodigo(res.getInt("reg_codvcn")));
		registro.setConsulta(ConsultaDAO.getInstance().carregarPorCodigo(res.getInt("reg_codcon")));
		registro.setDataVacina((res.getDate("con_dtvacina")));
		registro.setDataValidade((res.getDate("con_dtvalidade")));
		registro.setLote(res.getString("reg_lote"));
		registro.setDose(res.getInt("reg_dose"));
		
		return registro;
	}
	
}