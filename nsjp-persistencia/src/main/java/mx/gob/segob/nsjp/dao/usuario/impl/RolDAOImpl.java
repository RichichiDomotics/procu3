/**
 * Nombre del Programa  : RolDAOImpl.java
 * Autor                : Daniel Jim�nez
 * Compania             : TATTVA-IT
 * Proyecto             : NSJP                    Fecha: 27 Jul 2011
 * Marca de cambio      : N/A
 * Descripcion General  : Acceso a la informaci�n de Roles
 * Programa Dependiente : N/A
 * Programa Subsecuente : N/A
 * Cond. de ejecucion   : N/A
 * Dias de ejecucion    : N/A                             Horario: N/A
 *                              MODIFICACIONES
 *------------------------------------------------------------------------------
 * Autor                :N/A
 * Compania             :N/A
 * Proyecto             :N/A                                 Fecha: N/A
 * Modificacion         :N/A
 *------------------------------------------------------------------------------
 */
package mx.gob.segob.nsjp.dao.usuario.impl;

import java.util.List;

import mx.gob.segob.nsjp.comun.excepcion.NSJPNegocioException;
import mx.gob.segob.nsjp.comun.util.tl.PaginacionThreadHolder;
import mx.gob.segob.nsjp.dao.base.impl.GenericDaoHibernateImpl;
import mx.gob.segob.nsjp.dao.usuario.RolDAO;
import mx.gob.segob.nsjp.dto.base.PaginacionDTO;
import mx.gob.segob.nsjp.dto.rol.FiltroRolesDTO;
import mx.gob.segob.nsjp.model.Rol;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

/**
 * Acceso a la informaci�n de Roles
 * 
 * @version 1.0
 * @author Daniel Jim�nez
 * 
 */
@Repository
public class RolDAOImpl extends GenericDaoHibernateImpl<Rol, Long> implements
		RolDAO {

	@SuppressWarnings("unchecked")
	public List<Rol> consultarRoles(FiltroRolesDTO filtroRolesDTO)
			throws NSJPNegocioException {
		StringBuffer hqlQuery = new StringBuffer();
		hqlQuery.append("FROM Rol r ");
		hqlQuery.append(" WHERE esActivo = ").append(true)
				.append(" AND institucionPertenece = ")
				.append(filtroRolesDTO.getConfInstitucionId());
		if (filtroRolesDTO.getIdRolSelec() != null
				&& !filtroRolesDTO.getIdRolSelec().equals("")) {
			hqlQuery.append(" AND r.rolId not in ("
					+ filtroRolesDTO.getIdRolSelec() + ")");
		}
		
		if(filtroRolesDTO.getJerarquiaOrganizacionalId() != null 
				&& filtroRolesDTO.getJerarquiaOrganizacionalId()> 0){
			hqlQuery.append(" AND r.jerarquiaOrganizacional.jerarquiaOrganizacionalId = ")
					.append( filtroRolesDTO.getJerarquiaOrganizacionalId())
					.append(" ");
		}

		final PaginacionDTO pag = PaginacionThreadHolder.get();
		if (pag != null && pag.getCampoOrd() != null) {
			logger.debug("pag.getCampoOrd():" + pag.getCampoOrd());
			hqlQuery.append(" order by ");
			if (pag.getCampoOrd().equals("Clave")) {
				hqlQuery.append("r.nombreRol");
			} else {
				hqlQuery.append(pag.getCampoOrd());
			}

			hqlQuery.append(" ").append(pag.getDirOrd());
		}
		Query query = super.getSession().createQuery(hqlQuery.toString());
		if (pag != null && pag.getPage() != null) {
			query.setFirstResult(pag.getFirstResult());
			if (pag.getRows() != null & pag.getRows() > 0) {
				query.setMaxResults(pag.getRows());
			} else {
				query.setMaxResults(PaginacionDTO.DEFAULT_MAX_RESULT); // default
			}
		}
		logger.debug("query :: " + query);
		List<Rol> resp = query.list();
		logger.debug("resp.size() :: " + resp.size());

		if (pag != null && pag.getPage() != null) {
			query.setFirstResult(1);
			query.setMaxResults(-1);
			final List<Rol> temp = query.list();
			logger.debug("temp.size() :: " + temp.size());
			pag.setTotalRegistros(new Long(temp.size()));
			PaginacionThreadHolder.set(pag);
		}
		return resp;
	}

	@Override
	public Rol consultarRol(Rol rol) throws NSJPNegocioException {
		Rol rolResp = null;
		StringBuffer queryString = new StringBuffer();
		Query query = null;
		if (rol != null) {
			// Consulta rol por ID
			if (rol.getRolId() != null) {
				queryString.append(" FROM Rol r WHERE r.rolId = '")
						.append(rol.getRolId()).append("'");

			}//Consulta rol por nombre
			else if (!rol.getNombreRol().isEmpty()) {
				queryString.append(" FROM Rol r WHERE r.nombreRol = '")
						.append(rol.getNombreRol()).append("'");
			}
			query = super.getSession().createQuery(queryString.toString());
			if (!query.list().isEmpty()) {
				rolResp = (Rol) query.list().get(0);
			}

		}
		return rolResp;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Rol> consultarSubRoles(Rol rol) throws NSJPNegocioException {
		StringBuffer hqlQuery = new StringBuffer();
		hqlQuery.append("FROM Rol r ");
		hqlQuery.append(" WHERE esActivo = ").append(true)
				.append(" AND r.rolPadre = ").append(rol.getRolId());
		Query query = super.getSession().createQuery(hqlQuery.toString());
		logger.debug("query :: " + query);
		List<Rol> resp = query.list();
		logger.debug("resp.size() :: " + resp.size());
		return resp;
	}

	@Override
	public Rol consultarRolporIdRol(Long idRol) throws NSJPNegocioException {
		StringBuffer queryString = new StringBuffer();
		Query query=null;
		Rol rolResp = null;
		if (idRol != null) {
			queryString.append(" FROM Rol r WHERE r.rolId = '")
					.append(idRol).append("'");
			query = super.getSession().createQuery(queryString.toString());
			rolResp = (Rol) query.uniqueResult();
		
		}
		
		return rolResp;
		
	}

	@Override
	public String consultarCNombreRolPorIdRol(Long idRol)
			throws NSJPNegocioException {
		StringBuffer queryString = new StringBuffer();
		Query query=null;
		String rolResp = null;
		if (idRol != null) {
			queryString.append("SELECT r.nombreRol FROM Rol r WHERE r.rolId = '")
					.append(idRol).append("'");
			query = super.getSession().createQuery(queryString.toString());
			rolResp = (String) query.uniqueResult();
		
		}
		
		return rolResp;
	}

}
