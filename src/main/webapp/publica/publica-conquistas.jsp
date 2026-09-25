<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="nav.conquistas" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="conquistas" />
	</jsp:include>

	<main class="main-content">
		<!-- Page Hero Institucional (Figma #1010:532) -->
		<section class="page-hero-portal">
			<div class="container">
				<h1><fmt:message key="conquistas.titulo" /></h1>
				<p><fmt:message key="conquistas.subtitulo" /></p>
			</div>
		</section>

		<!-- Conteúdo Principal: Histórico de Premiações (Figma #1010:538) -->
		<section class="container mb-5">
			<div class="mb-4">
				<h2 class="fw-bold m-0" style="color: var(--color-text-primary); font-size: 26px;">
					<fmt:message key="conquistas.historico.titulo" />
				</h2>
			</div>

			<c:choose>
				<c:when test="${empty conquistas}">
					<div class="text-center py-5">
						<i class="fa-solid fa-trophy fa-3x text-muted mb-3"></i>
						<p class="text-secondary"><fmt:message key="conquistas.nenhuma" /></p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row g-4">
						<c:forEach var="conq" items="${conquistas}">
							<div class="col-lg-6">
								<div class="card-conquista-figma">
									<div>
										<div class="d-flex justify-content-between align-items-start mb-2">
											<h4 class="fw-bold mb-1" style="color: var(--color-text-primary); font-size: 20px;">
												<c:out value="${conq.titulo}" />
											</h4>
											<div class="stat-icon orange flex-shrink-0" style="width: 40px; height: 40px; font-size: 16px;">
												<i class="fa-solid fa-trophy"></i>
											</div>
										</div>

										<div class="small text-secondary mb-3">
											<i class="fa-regular fa-calendar-check me-1" style="color: var(--color-primary);"></i>
											<span><c:out value="${conq.data}" /></span>
										</div>

										<p class="text-secondary mb-3" style="line-height: 1.6; font-size: 14.5px;">
											<c:out value="${conq.descricao}" />
										</p>
									</div>

									<!-- Box Relacionando Atividade e Coordenador (Figma #1010:555) -->
									<c:if test="${not empty conq.atividade}">
										<div class="conquista-relation-box">
											<div class="d-flex align-items-center gap-2 mb-1">
												<i class="fa-solid fa-diagram-project text-primary fa-sm"></i>
												<span>
													<strong><fmt:message key="conquistas.box.atividade" />:</strong>
													<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${conq.atividade.id}" class="text-decoration-none fw-semibold" style="color: var(--color-secondary);">
														<c:out value="${conq.atividade.titulo}" />
													</a>
												</span>
											</div>
											<c:if test="${not empty conq.atividade.coordenador}">
												<div class="d-flex align-items-center gap-2">
													<i class="fa-solid fa-user-tie text-success fa-sm"></i>
													<span>
														<strong><fmt:message key="conquistas.box.coordenador" />:</strong>
														<c:out value="${conq.atividade.coordenador.nome}" />
													</span>
												</div>
											</c:if>
										</div>
									</c:if>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</section>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
