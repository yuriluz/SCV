package com.scv.servlet;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.scv.entities.enums.Sexo;
import com.scv.javabean.Pessoa;
import com.scv.javabean.Registro;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.dao.RegistroDAO;
import com.scv.persistence.exception.DAOException;

public class CardReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CardReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document document = new Document(PageSize.A4.rotate(), 85, 85, 57, 57);
            PdfWriter.getInstance(document, baos);
            
            Integer codigo = Integer.parseInt(request.getParameter("codPessoa"));
            Pessoa pessoa = PessoaDAO.getInstance().carregarPorCodigo(codigo);
            
    		Sexo sexoPessoa = pessoa.getSexo();
    		String sexo = "Outro";
    		String tipoDoc = "";
    		String nDoc = "";
    		String emissor = "";
    		
    		if (sexoPessoa.getValue().equals("M")) {
    			sexo = "Masculino";
    		} else if (sexoPessoa.getValue().equals("F")) {
    			sexo = "Feminino";
    		} else if (sexoPessoa.getValue().equals("")) { 
    			sexo = "Outro";
    		}
    		
    		if (!pessoa.getDocumento().isEmpty()) {
    			switch(pessoa.getTipoDocumento()) {
    			case RG:
    				tipoDoc = "RG";
    				break;
    			case CNH:
    				tipoDoc = "CNH";
    				break;
    			case CTPS:
    				tipoDoc = "CTPS";
    				break;
    			case PASSAPORTE:
    				tipoDoc = "Passaporte";
    				break;
    			}
    			nDoc = pessoa.getDocumento();
    			emissor = " - " + pessoa.getEmissor();
    		} else {
    			tipoDoc = "CPF";
    			nDoc = pessoa.getCpf();
    		}
    		
    		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
            
            document.open();
            document.addSubject("Cartão de Vacinação"); 
            document.addCreator("Sistema de Controle de Vacinação");
            document.addAuthor("");
            document.addCreationDate();
            
            Font textFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL);
            Font fieldFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD);
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD);
            
            String tipoImpressao = request.getParameter("print");
            
            Paragraph paragraph = new Paragraph("CARTÃO DE VACINAÇÃO", titleFont);
            paragraph.setAlignment(Element.ALIGN_CENTER);
            paragraph.setSpacingAfter(48);
            document.add(paragraph);
            
            paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
            paragraph = new Paragraph("Nome: ", fieldFont);
            paragraph.add(new Chunk(pessoa.getNome().toUpperCase(), textFont));
            paragraph.setSpacingAfter(24);
            document.add(paragraph);
            
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            table.setSpacingAfter(24);
            PdfPCell cell = new PdfPCell();
            
            paragraph = new Paragraph("Sexo: ", fieldFont);
            paragraph.add(new Chunk(sexo.toUpperCase(), textFont));
            cell = new PdfPCell(paragraph);
            cell.setBorder(Rectangle.NO_BORDER);
            table.addCell(cell);
            
            paragraph = new Paragraph("Data de Nascimento: ", fieldFont);
            paragraph.add(new Chunk(df.format(pessoa.getDataNascimento()), textFont));
            cell = new PdfPCell(paragraph);
            cell.setBorder(Rectangle.NO_BORDER);
            table.addCell(cell);
            
            paragraph = new Paragraph("Nacionalidade: ", fieldFont);
            paragraph.add(new Chunk(pessoa.getNacionalidade(), textFont));
            cell = new PdfPCell(paragraph);
            cell.setBorder(Rectangle.NO_BORDER);
            table.addCell(cell);
            document.add(table);
            
            paragraph = new Paragraph("Documento nacional de identificação: ", fieldFont);
            paragraph.add(new Chunk(tipoDoc + " - " + nDoc + emissor, textFont));
            paragraph.setSpacingAfter(24);
            document.add(paragraph);
            
            if (tipoImpressao.equals("1")) {
	            paragraph = new Paragraph("Cuja assinatura segue   ", fieldFont);
	            paragraph.add(new Chunk("________________________________________________", textFont));
	            paragraph.setSpacingAfter(24);
	            document.add(paragraph);
            }
            
            paragraph = new Paragraph("Foi vacinado nas datas indicadas contra:", fieldFont);
            paragraph.setSpacingAfter(24);
            document.add(paragraph);
            
            table = new PdfPTable(6);
            table.setSpacingAfter(24);
            table.setWidthPercentage(100);
            
            paragraph = new Paragraph("Vacina", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.LEFT | PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
            paragraph = new Paragraph("Data", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
            paragraph = new Paragraph("Profissional de saúde responsável", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
            paragraph = new Paragraph("Número de lote", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
            paragraph = new Paragraph("Validade", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
            paragraph = new Paragraph("Unidade de Saúde", fieldFont);
            cell = new PdfPCell(paragraph);
            cell.setBorder(PdfPCell.RIGHT | PdfPCell.BOTTOM | PdfPCell.TOP);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(5f);
            table.addCell(cell);
    		
    		List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(pessoa);
            
            for (Registro r : registros) {
            	if (r.getVerificado()) {
	            	paragraph = new Paragraph(r.getVacina().getNome(), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.LEFT | PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
	                paragraph = new Paragraph(df.format(r.getDataVacina()), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
	                paragraph = new Paragraph(r.getConsulta().getVacinador().getNome() == null ? r.getVerificador().getNome() + " (verificado em " + df.format(r.getDataVerificacao()) + ")" : r.getConsulta().getVacinador().getNome(), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
	                paragraph = new Paragraph(r.getLote(), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
	                paragraph = new Paragraph(df.format(r.getDataValidade()), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
	                paragraph = new Paragraph(r.getConsulta().getUnidade().getNomeFantasia(), textFont);
	                cell = new PdfPCell(paragraph);
	                cell.setBorder(PdfPCell.RIGHT | PdfPCell.BOTTOM | PdfPCell.TOP);
	                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	                cell.setPadding(5f);
	                table.addCell(cell);
            	}
            }
            
            document.add(table);
            
            document.close();
            
         // setting some response headers
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control",
                "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            // setting the content type
            response.setContentType("application/pdf");
            // the contentlength
            response.setContentLength(baos.size());
            // write ByteArrayOutputStream to the ServletOutputStream
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
        } catch (DocumentException | ClassNotFoundException | DAOException ex) {
        	throw new IOException(ex.getMessage());
        } 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
