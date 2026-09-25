<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="app.nome" /> — <fmt:message key="app.instituicao" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="inicio" />
	</jsp:include>

	<main class="main-content">
		<!-- Hero Section com Verde Sólido Institucional (Figma #1001:67) -->
		<section class="hero-portal-solid">
			<div class="container">
				<div class="row align-items-center gy-4">
					<!-- Coluna Principal (Texto e Ações) -->
					<div class="col-lg-7">
						<div class="hero-pill">
							<i class="fa-solid fa-microchip"></i>
							<span><fmt:message key="inicio.tag" /></span>
						</div>
						<h1><fmt:message key="inicio.titulo" /></h1>
						<p class="hero-lead"><fmt:message key="inicio.subtitulo" /></p>
						<div class="d-flex align-items-center gap-3 flex-wrap">
							<a href="${pageContext.request.contextPath}/atividades" class="btn-hero-red">
								<i class="fa-solid fa-compass"></i>
								<span><fmt:message key="inicio.btn.explorar" /></span>
							</a>
							<a href="${pageContext.request.contextPath}/sobre" class="btn-hero-outline">
								<i class="fa-solid fa-circle-info"></i>
								<span><fmt:message key="inicio.btn.sobre" /></span>
							</a>
						</div>
					</div>

					<!-- Coluna Direita: Preview do Destaque da Semana (Figma #1001:88) -->
					<div class="col-lg-5">
						<div class="card-hero-preview">
							<div class="preview-header">
								<span class="badge-destaque">
									<i class="fa-solid fa-star text-warning me-1"></i>
									<fmt:message key="inicio.destaque.badge" />
								</span>
								<span class="badge-periodo-destaque">2026/1</span>
							</div>
							<h4 class="fw-bold mb-2 text-white">Projeto Negrótica PICTEC</h4>
							<p class="small mb-3" style="color: rgba(255,255,255,0.85); line-height: 1.6;">
								Pesquisa e extensão unindo robótica pedagógica e impacto social com participação de estudantes do IFMS.
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Floating Stats Bar (Figma #1001:235) -->
		<div class="container hero-stats-wrapper">
			<div class="row g-3">
				<div class="col-md-4">
					<div class="stat-box-figma">
						<div class="stat-num">
							<c:choose>
								<c:when test="${totalAtividades > 0}">${totalAtividades}+</c:when>
								<c:otherwise>12+</c:otherwise>
							</c:choose>
						</div>
						<div class="stat-tit"><fmt:message key="inicio.stats.projetos.ativos" /></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-box-figma">
						<div class="stat-num">
							<c:choose>
								<c:when test="${totalEstudantes > 0}">${totalEstudantes}+</c:when>
								<c:otherwise>45+</c:otherwise>
							</c:choose>
						</div>
						<div class="stat-tit"><fmt:message key="inicio.stats.estudantes.envolvidos" /></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-box-figma">
						<div class="stat-num">
							<c:choose>
								<c:when test="${totalConquistas > 0}">0${totalConquistas}</c:when>
								<c:otherwise>08</c:otherwise>
							</c:choose>
						</div>
						<div class="stat-tit"><fmt:message key="inicio.stats.premiacoes" /></div>
					</div>
				</div>
			</div>
		</div>

		<!-- Seção: O Que Desenvolvemos / Projetos & Atividades Recentes (Figma #1001:3) -->
		<section class="container mb-5">
			<div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-2">
				<div>
					<span class="text-uppercase fw-bold small d-block mb-1" style="color: #059669; letter-spacing: 0.08em;">
						<fmt:message key="inicio.secao.atividades.tag" />
					</span>
					<h2 class="fw-bold m-0" style="color: var(--color-secondary); font-size: 28px;">
						<fmt:message key="inicio.secao.atividades.titulo" />
					</h2>
				</div>
				<a href="${pageContext.request.contextPath}/atividades" class="btn-portal-outline">
					<fmt:message key="inicio.ver.todas" />
					<i class="fa-solid fa-arrow-right ms-1"></i>
				</a>
			</div>

			<div class="row g-4">
				<c:forEach var="ativ" items="${destaques}">
					<div class="col-md-6 col-lg-4">
						<div class="card-portal h-100 d-flex flex-column justify-content-between">
							<div class="card-portal-body">
								<div class="d-flex justify-content-between align-items-center mb-3">
									<span class="badge-portal badge-tipo">
										<c:out value="${ativ.tipo}" />
									</span>

									<span class="badge-portal ${ativ.situacao == 'Concluída' ? 'badge-situacao-concluida' : (ativ.situacao == 'Em andamento' ? 'badge-situacao-andamento' : 'badge-situacao-planejada')}">
										<c:out value="${ativ.situacao}" />
									</span>
								</div>

								<h5 class="fw-bold mb-2" style="color: var(--color-text-primary); font-size: 18px;">
									<c:out value="${ativ.titulo}" />
								</h5>

								<p class="small text-secondary mb-3" style="line-height: 1.6; min-height: 54px;">
									<c:out value="${ativ.descricao}" />
								</p>

								<c:if test="${not empty ativ.periodos}">
									<div class="mb-3 d-flex flex-wrap gap-1">
										<c:forEach var="p" items="${ativ.periodos}">
											<span class="badge-periodo">
												<i class="fa-regular fa-calendar me-1"></i>
												<c:out value="${p.rotulo}" />
											</span>
										</c:forEach>
									</div>
								</c:if>
							</div>

							<div class="card-portal-header bg-light">
								<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${ativ.id}" class="btn-portal-primary btn-sm w-100 justify-content-center">
									<fmt:message key="btn.detalhes" />
									<i class="fa-solid fa-chevron-right ms-1"></i>
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>

		<!-- Seção: Linha do Tempo da Robótica (Figma #1001:103) -->
		<section id="trajetoria" class="py-5" style="background-color: #F8FAFC; border-top: 1px solid #E2E8F0; border-bottom: 1px solid #E2E8F0;">
			<div class="container">
				<div class="text-center mb-5">
					<span class="text-uppercase fw-bold small d-block mb-1" style="color: #059669; letter-spacing: 0.08em;">
						<fmt:message key="inicio.timeline.tag" />
					</span>
					<h2 class="fw-bold m-0" style="color: var(--color-secondary); font-size: 28px;">
						<fmt:message key="inicio.timeline.titulo" />
					</h2>
				</div>

				<div class="timeline-portal-wrapper">
					<!-- Marco 1: 2018 -->
					<div class="timeline-portal-item">
						<div class="timeline-portal-node node-green"></div>
						<div class="timeline-portal-card">
							<span class="timeline-date-badge"><fmt:message key="inicio.timeline.1.data" /></span>
							<h5 class="fw-bold text-dark mb-2"><fmt:message key="inicio.timeline.1.titulo" /></h5>
							<p class="small text-secondary m-0" style="line-height: 1.6;">
								<fmt:message key="inicio.timeline.1.desc" />
							</p>
						</div>
					</div>

					<!-- Marco 2: 2022 -->
					<div class="timeline-portal-item">
						<div class="timeline-portal-node node-blue"></div>
						<div class="timeline-portal-card">
							<span class="timeline-date-badge" style="color: #0A3663;"><fmt:message key="inicio.timeline.2.data" /></span>
							<h5 class="fw-bold text-dark mb-2"><fmt:message key="inicio.timeline.2.titulo" /></h5>
							<p class="small text-secondary m-0" style="line-height: 1.6;">
								<fmt:message key="inicio.timeline.2.desc" />
							</p>
						</div>
					</div>

					<!-- Marco 3: 2025 -->
					<div class="timeline-portal-item">
						<div class="timeline-portal-node node-amber"></div>
						<div class="timeline-portal-card">
							<span class="timeline-date-badge" style="color: #D97706;"><fmt:message key="inicio.timeline.3.data" /></span>
							<h5 class="fw-bold text-dark mb-2"><fmt:message key="inicio.timeline.3.titulo" /></h5>
							<p class="small text-secondary m-0" style="line-height: 1.6;">
								<fmt:message key="inicio.timeline.3.desc" />
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Seção: Conquistas & Impacto (Figma #1001:148) -->
		<section class="container py-5">
			<div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-2">
				<div>
					<span class="text-uppercase fw-bold small d-block mb-1" style="color: #059669; letter-spacing: 0.08em;">
						<fmt:message key="inicio.conquistas.tag" />
					</span>
					<h2 class="fw-bold m-0" style="color: var(--color-text-primary); font-size: 28px;">
						<fmt:message key="inicio.conquistas.titulo" />
					</h2>
				</div>
				<a href="${pageContext.request.contextPath}/conquistas" class="btn-portal-outline">
					<fmt:message key="inicio.conquistas.ver.todas" />
					<i class="fa-solid fa-trophy ms-1 text-warning"></i>
				</a>
			</div>

			<div class="row g-4">
				<c:choose>
					<c:when test="${not empty conquistas}">
						<c:forEach var="c" items="${conquistas}" end="1">
							<div class="col-md-6">
								<div class="card-portal p-4 h-100">
									<div class="d-flex align-items-center gap-3 mb-3">
										<div class="stat-icon orange" style="width: 48px; height: 48px; font-size: 20px;">
											<i class="fa-solid fa-trophy"></i>
										</div>
										<div>
											<h5 class="fw-bold m-0" style="color: var(--color-text-primary);"><c:out value="${c.titulo}" /></h5>
											<span class="small text-secondary"><c:out value="${c.data}" /></span>
										</div>
									</div>
									<p class="small text-secondary mb-0" style="line-height: 1.6;">
										<c:out value="${c.descricao}" />
									</p>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<!-- Fallback cards como no Figma -->
						<div class="col-md-6">
							<div class="card-portal p-4 h-100">
								<div class="d-flex align-items-center gap-3 mb-3">
									<div class="stat-icon orange" style="width: 48px; height: 48px; font-size: 20px;">
										<i class="fa-solid fa-trophy"></i>
									</div>
									<div>
										<h5 class="fw-bold m-0" style="color: var(--color-text-primary);">2º Lugar na OBR Estadual (Modalidade Artística)</h5>
										<span class="small text-secondary">Edição 2025 • Etapa Mato Grosso do Sul</span>
									</div>
								</div>
								<p class="small text-secondary mb-0" style="line-height: 1.6;">
									Apresentação do protótipo animatrônico desenvolvido integralmente por estudantes do IFMS Campus Campo Grande.
								</p>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card-portal p-4 h-100">
								<div class="d-flex align-items-center gap-3 mb-3">
									<div class="stat-icon blue" style="width: 48px; height: 48px; font-size: 20px;">
										<i class="fa-solid fa-award"></i>
									</div>
									<div>
										<h5 class="fw-bold m-0" style="color: var(--color-text-primary);">Destaque em Inovação Tecnológica</h5>
										<span class="small text-secondary">Feira de Ciência e Tecnologia 2025</span>
									</div>
								</div>
								<p class="small text-secondary mb-0" style="line-height: 1.6;">
									Reconhecimento pelo desenvolvimento do projeto de extensão focado na inclusão digital através da robótica.
								</p>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<!-- Instagram Callout Banner (Figma #1001:187) -->
		<section class="container mb-5">
			<div class="p-4 p-md-5 rounded-4 shadow-sm text-white" style="background: linear-gradient(135deg, #0A3663 0%, #1e5b96 60%, #bc1888 100%);">
				<div class="row align-items-center gy-3">
					<div class="col-md-8">
						<span class="badge bg-white text-dark fw-bold mb-2 px-3 py-1">Instagram</span>
						<h3 class="fw-bold mb-2"><fmt:message key="inicio.instagram.titulo" /></h3>
						<p class="m-0 text-white-50"><fmt:message key="inicio.instagram.subtitulo" /></p>
					</div>
					<div class="col-md-4 text-md-end">
						<a href="https://www.instagram.com/robotican.cg/" target="_blank" rel="noopener noreferrer" class="instagram-btn px-4 py-2 fs-6">
							<i class="fa-brands fa-instagram fa-lg"></i>
							<span>@robotican.cg</span>
						</a>
					</div>
				</div>
			</div>
		</section>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
