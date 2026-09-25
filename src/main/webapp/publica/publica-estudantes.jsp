<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="estudantes.titulo" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="estudantes" />
	</jsp:include>

	<main class="main-content">
		<!-- Page Hero Institucional (Figma #1007:358) -->
		<section class="page-hero-portal">
			<div class="container">
				<h1><fmt:message key="estudantes.titulo" /></h1>
				<p><fmt:message key="estudantes.subtitulo" /></p>
			</div>
		</section>

		<!-- Seção Principal: Membros do Laboratório (Figma #1007:364) -->
		<section class="container mb-5">
			<div class="mb-4">
				<h2 class="fw-bold m-0" style="color: var(--color-text-primary); font-size: 26px;">
					<fmt:message key="estudantes.secao.membros" />
				</h2>
			</div>

			<c:choose>
				<c:when test="${empty estudantes}">
					<div class="text-center py-5">
						<i class="fa-solid fa-users-slash fa-3x text-muted mb-3"></i>
						<p class="text-secondary"><fmt:message key="estudantes.nenhum" /></p>
					</div>
				</c:when>
				<c:otherwise>
					<!-- Grid Centralizado do Figma (#1007:367) -->
					<div class="row g-4 justify-content-center">
						<c:forEach var="est" items="${estudantes}">
							<div class="col-md-6 col-lg-4">
								<div class="card-student-figma">
									<!-- Avatar Centralizado 80px -->
									<c:choose>
										<c:when test="${not empty est.foto && est.foto.startsWith('http')}">
											<img src="${est.foto}" alt="${est.nome}" class="card-student-avatar">
										</c:when>
										<c:otherwise>
											<div class="card-student-avatar-placeholder" title="Perfil sem foto">
												<i class="fa-solid fa-user"></i>
											</div>
										</c:otherwise>
									</c:choose>

									<!-- Nome do Estudante -->
									<h4 class="student-name-figma">
										<c:out value="${est.nome}" />
									</h4>

									<!-- Minibio / Curso -->
									<p class="student-bio-figma">
										<c:choose>
											<c:when test="${not empty est.minibio}">
												<c:out value="${est.minibio}" />
											</c:when>
											<c:otherwise>
												<fmt:message key="estudantes.minibio.padrao" />
											</c:otherwise>
										</c:choose>
									</p>

									<!-- Divisor e Badges de Participações -->
									<div class="student-participacoes-divider">
										<div class="student-participacoes-title">
											<i class="fa-solid fa-link fa-xs me-1"></i>
											<fmt:message key="estudantes.participacoes.label" />:
										</div>
										<c:choose>
											<c:when test="${not empty est.participacoes}">
												<div>
													<c:forEach var="part" items="${est.participacoes}">
														<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${part.atividade.id}" 
														   class="student-activity-pill" 
														   title="<c:out value='${part.funcao}' />">
															<c:out value="${part.atividade.titulo}" />
														</a>
													</c:forEach>
												</div>
											</c:when>
											<c:otherwise>
												<span class="small text-muted fst-italic">
													<fmt:message key="estudantes.sem.atividades" />
												</span>
											</c:otherwise>
										</c:choose>
									</div>
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
