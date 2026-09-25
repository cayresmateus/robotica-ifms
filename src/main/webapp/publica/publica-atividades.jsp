<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="atividades.titulo" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="atividades" />
	</jsp:include>

	<main class="main-content">
		<!-- Page Hero Institucional (Figma #1006:178) -->
		<section class="page-hero-portal">
			<div class="container">
				<h1><fmt:message key="atividades.titulo" /></h1>
				<p><fmt:message key="atividades.subtitulo" /></p>
			</div>
		</section>

		<div class="container mb-5">
			<!-- Barra de Filtros em Pílulas (Figma #1006:185) -->
			<div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4 pb-2 border-bottom">
				<div class="filter-pills-bar">
					<a href="${pageContext.request.contextPath}/atividades" class="filter-pill ${empty filtroTipo ? 'active' : ''}">
						<fmt:message key="atividades.filtro.todas" />
					</a>
					<a href="${pageContext.request.contextPath}/atividades?tipo=Projeto" class="filter-pill ${filtroTipo == 'Projeto' ? 'active' : ''}">
						<fmt:message key="atividades.filtro.projetos" />
					</a>
					<a href="${pageContext.request.contextPath}/atividades?tipo=Estágio" class="filter-pill ${filtroTipo == 'Estágio' ? 'active' : ''}">
						<fmt:message key="atividades.filtro.estagios" />
					</a>
					<a href="${pageContext.request.contextPath}/atividades?tipo=Oficina" class="filter-pill ${filtroTipo == 'Oficina' ? 'active' : ''}">
						<fmt:message key="atividades.filtro.oficinas" />
					</a>
				</div>

				<!-- Filtro por Período Letivo -->
				<form action="${pageContext.request.contextPath}/atividades" method="get" class="d-flex align-items-center gap-2">
					<c:if test="${not empty filtroTipo}">
						<input type="hidden" name="tipo" value="${filtroTipo}">
					</c:if>
					<label for="periodoSelect" class="small fw-bold text-nowrap" style="color: var(--color-secondary);">
						<i class="fa-solid fa-calendar-days me-1"></i>
						<fmt:message key="atividades.filtro.periodo" />:
					</label>
					<select id="periodoSelect" name="periodoId" class="form-select-portal" style="max-width: 170px; padding: 6px 12px; font-size: 13px;" onchange="this.form.submit()">
						<option value=""><fmt:message key="atividades.filtro.todos" /></option>
						<c:forEach var="p" items="${periodos}">
							<option value="${p.id}" ${filtroPeriodoId == p.id ? 'selected' : ''}>
								<c:out value="${p.rotulo}" />
							</option>
						</c:forEach>
					</select>
				</form>
			</div>

			<!-- Grid de Cards de Atividades (Figma #1006:197) -->
			<c:choose>
				<c:when test="${empty atividades}">
					<div class="text-center py-5">
						<i class="fa-solid fa-folder-open fa-3x text-muted mb-3"></i>
						<p class="text-secondary"><fmt:message key="atividades.nenhuma" /></p>
						<a href="${pageContext.request.contextPath}/atividades" class="btn btn-outline-secondary btn-sm">
							<fmt:message key="atividades.limpar.filtros" />
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row g-4">
						<c:forEach var="ativ" items="${atividades}">
							<div class="col-md-6 col-lg-4">
								<div class="card-portal h-100 d-flex flex-column justify-content-between" style="border-radius: 12px;">
									<div class="card-portal-body">
										<!-- Tag de Categoria -->
										<div class="d-flex justify-content-between align-items-center mb-3">
											<span class="badge-portal badge-tipo">
												<c:out value="${ativ.tipo}" />
											</span>

											<span class="badge-portal ${ativ.situacao == 'Concluída' ? 'badge-situacao-concluida' : (ativ.situacao == 'Em andamento' ? 'badge-situacao-andamento' : 'badge-situacao-planejada')}" style="font-size: 11px;">
												<c:out value="${ativ.situacao}" />
											</span>
										</div>

										<!-- Título da Atividade -->
										<h5 class="fw-bold mb-2">
											<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${ativ.id}" class="text-decoration-none" style="color: var(--color-text-primary);">
												<c:out value="${ativ.titulo}" />
											</a>
										</h5>

										<!-- Descrição -->
										<p class="small text-secondary mb-3" style="line-height: 1.6; min-height: 50px;">
											<c:out value="${ativ.descricao}" />
										</p>

										<!-- Coordenador Responsável -->
										<c:if test="${not empty ativ.coordenador}">
											<div class="small mb-3" style="color: var(--color-text-secondary);">
												<i class="fa-solid fa-user-tie me-1" style="color: var(--color-primary);"></i>
												<span>Coord.: <strong><c:out value="${ativ.coordenador.nome}" /></strong></span>
											</div>
										</c:if>
									</div>

									<!-- Rodapé do Card: Período e Ação -->
									<div class="card-portal-header bg-light d-flex justify-content-between align-items-center">
										<div>
											<c:choose>
												<c:when test="${not empty ativ.periodos}">
													<c:forEach var="p" items="${ativ.periodos}">
														<span class="badge-periodo me-1">
															<i class="fa-regular fa-calendar me-1"></i><c:out value="${p.rotulo}" />
														</span>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<span class="text-muted small">—</span>
												</c:otherwise>
											</c:choose>
										</div>
										<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${ativ.id}" class="btn btn-sm btn-outline-success fw-bold" style="border-radius: 6px; font-size: 12px;">
											<fmt:message key="btn.detalhes" />
											<i class="fa-solid fa-chevron-right ms-1"></i>
										</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
