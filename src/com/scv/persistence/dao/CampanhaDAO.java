package com.scv.persistence.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.scv.javabean.Campanha;
import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.persistence.exception.DAOException;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CampanhaDAO extends BaseDAO{
	
    private static CampanhaDAO singleton;
    private static Logger LOGGER = Logger.getLogger(CampanhaDAO.class.getName());

    public static CampanhaDAO getInstance() {
        if (singleton == null) {
            singleton = new CampanhaDAO();
        }
        return singleton;
    }
	
	public void inserir(Campanha campanha) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "INSERT INTO campanha_cam (cam_nome, cam_descricao, "
	    		+ "cam_dtinicio, cam_dtfim, cam_codvcn) "
	    		+ "VALUES(?,?,?,?,?)";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, campanha.getNome());
	        pstmt.setString(2, campanha.getDescricao());
	        pstmt.setDate(3, (Date) campanha.getDataInicio());
	        pstmt.setDate(4, (Date) campanha.getDataFim());
	        pstmt.setInt(5, campanha.getVacina().getCodigo());

	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria nova campanha";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public void alterar(Campanha campanha) throws DAOException, ClassNotFoundException {
		
		Connection con = null;
        PreparedStatement pstmt = null;
	    String query = "UPDATE campanha_cam SET cam_nome = ?, cam_descricao = ?, cam_dtinicio = ?, "
	    		+ "cam_dtfim = ?, cam_codvcn = ? WHERE cam_codcam = ?";	    
	    
	    try {
	    	con = getConnection();
	        pstmt = con.prepareStatement(query);

	        pstmt.setString(1, campanha.getNome());
	        pstmt.setString(2, campanha.getDescricao());
	        pstmt.setDate(3, (Date) campanha.getDataInicio());
	        pstmt.setDate(4, (Date) campanha.getDataFim());
	        pstmt.setInt(5, campanha.getVacina().getCodigo());
	        pstmt.setInt(6, campanha.getCodigo());
	        
	        pstmt.execute();
	        
	    } catch (SQLException e) {
	    	String msg = "SQLException enquanto inseria alterações no registro da campanha (" + campanha.getCodigo() +")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
	    } finally {
	    	close(con, pstmt);
	    }
	}
	
	public List<Campanha> carregarTodos() throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as campanhas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public List<Campanha> carregarTodasNacionais() throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam where cam_codcid is null and cam_codest is null";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as campanhas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public List<Campanha> carregarTodasEmAndamento() throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();
		
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam where cam_codcid is null and cam_codest is null "
        		+ "and cam_dtinicio <= curdate() and cam_dtfim >= curdate()";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as campanhas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public List<Campanha> carregarTodasEmAndamento(Estado estado, Cidade cidade) throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();
		
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam where cam_codcid = ? and cam_codest = ? "
        		+ "and cam_dtinicio <= curdate() and cam_dtfim >= curdate()";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, cidade.getCodigo());
            pstmt.setInt(2, estado.getCodigo());
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava todas as campanhas";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public List<Campanha> carregarTodasPorCidade(Cidade cidade) throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam where cam_codcid = ? and cam_codest = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, cidade.getCodigo());
            pstmt.setInt(2, cidade.getEstado().getCodigo());
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava as campanhas para a cidade: " + cidade.getNome() + " (" + cidade.getCodigo()+ ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public List<Campanha> carregarTodasPorEstado(Estado estado) throws DAOException, ClassNotFoundException {
		List<Campanha> campanhas = new ArrayList<Campanha>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "select * from campanha_cam where cam_codest = ? and cam_codcid is null";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, estado.getCodigo());
            res = pstmt.executeQuery();
            while (res.next()) {
                Campanha campanha = gerarCampanha(res);
                campanhas.add(campanha);
            }
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava as campanhas para o estado: " + estado.getNome() + " (" + estado.getCodigo() + ")" ;
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanhas;
	}
	
	public Campanha carregarPorCodigo(Integer codigo) throws DAOException, ClassNotFoundException {
		Campanha campanha = new Campanha();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        String query = "SELECT * FROM campanha_cam WHERE cam_codcam = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, codigo);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
            	campanha = gerarCampanha(res);
            }
            
        } catch (SQLException e) {
            String msg = "SQLException enquanto carregava a campanha (" + codigo.toString() + ")";
            LOGGER.log(Level.SEVERE, msg, e);
            throw new DAOException(msg, e);
        } finally {
            close(con, pstmt, res);
        }
        return campanha;
	}

	private Campanha gerarCampanha(ResultSet res) throws SQLException, DAOException, ClassNotFoundException {
		Campanha campanha = new Campanha();
		
		campanha.setCodigo(res.getInt("cam_codcam"));
		campanha.setNome(res.getString("cam_nome"));
		campanha.setDescricao(res.getString("cam_descricao"));
		campanha.setDataInicio(res.getDate("cam_dtinicio"));
		campanha.setDataFim(res.getDate("cam_dtfim"));
		campanha.setVacina(VacinaDAO.getInstance().carregarPorCodigo(res.getInt("cam_codvcn")));
		campanha.setCidade(CidadeDAO.getInstance().carregarPorCodigo(res.getInt("cam_codcid")));
		campanha.setEstado(EstadoDAO.getInstance().carregarPorCodigo(res.getInt("cam_codest")));
		
		return campanha;
	}
	
}
