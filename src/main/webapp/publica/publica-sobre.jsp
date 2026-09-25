<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="sobre.titulo" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="sobre" />
	</jsp:include>

	<main class="main-content">
		<!-- Page Hero Institucional (Figma #1006:3) -->
		<section class="page-hero-portal">
			<div class="container">
				<h1><fmt:message key="sobre.titulo" /></h1>
				<p><fmt:message key="sobre.subtitulo" /></p>
			</div>
		</section>

		<!-- Conteúdo Principal: Missão e Atuação (Figma #1006:9) -->
		<section class="container mb-5">
			<div class="mb-4">
				<span class="text-uppercase fw-bold small d-block mb-1" style="color: #059669; letter-spacing: 0.08em;">
					IDENTIDADE INSTITUCIONAL
				</span>
				<h2 class="fw-bold m-0" style="color: var(--color-secondary); font-size: 28px;">
					Nossa Missão e Atuação
				</h2>
			</div>

			<!-- Linha 1: Missão e Visão (2 Cards) -->
			<div class="row g-4 mb-4">
				<div class="col-lg-6">
					<div class="card-portal p-4 h-100">
						<div class="d-flex align-items-center gap-3 mb-3">
							<div class="stat-icon green" style="width: 44px; height: 44px; font-size: 18px;">
								<i class="fa-solid fa-bullseye"></i>
							</div>
							<h4 class="fw-bold m-0" style="color: var(--color-text-primary); font-size: 20px;">
								<fmt:message key="sobre.missao.titulo" />
							</h4>
						</div>
						<p class="text-secondary m-0" style="line-height: 1.7; font-size: 14.5px;">
							<fmt:message key="sobre.missao.texto" />
						</p>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="card-portal p-4 h-100">
						<div class="d-flex align-items-center gap-3 mb-3">
							<div class="stat-icon blue" style="width: 44px; height: 44px; font-size: 18px;">
								<i class="fa-solid fa-eye"></i>
							</div>
							<h4 class="fw-bold m-0" style="color: var(--color-text-primary); font-size: 20px;">
								<fmt:message key="sobre.visao.titulo" />
							</h4>
						</div>
						<p class="text-secondary m-0" style="line-height: 1.7; font-size: 14.5px;">
							<fmt:message key="sobre.visao.texto" />
						</p>
					</div>
				</div>
			</div>

			<!-- Linha 2: Os 3 Pilares (Ensino, Pesquisa, Extensão) -->
			<div class="row g-4">
				<div class="col-md-4">
					<div class="card-portal p-4 h-100">
						<div class="d-flex align-items-center gap-2 mb-3">
							<i class="fa-solid fa-book-open text-primary fa-lg"></i>
							<h5 class="fw-bold m-0" style="color: var(--color-text-primary);">
								<fmt:message key="sobre.ensino.titulo" />
							</h5>
						</div>
						<p class="small text-secondary m-0" style="line-height: 1.6;">
							<fmt:message key="sobre.ensino.desc" />
						</p>
					</div>
				</div>

				<div class="col-md-4">
					<div class="card-portal p-4 h-100">
						<div class="d-flex align-items-center gap-2 mb-3">
							<i class="fa-solid fa-flask text-success fa-lg"></i>
							<h5 class="fw-bold m-0" style="color: var(--color-text-primary);">
								<fmt:message key="sobre.pesquisa.titulo" />
							</h5>
						</div>
						<p class="small text-secondary m-0" style="line-height: 1.6;">
							<fmt:message key="sobre.pesquisa.desc" />
						</p>
					</div>
				</div>

				<div class="col-md-4">
					<div class="card-portal p-4 h-100">
						<div class="d-flex align-items-center gap-2 mb-3">
							<i class="fa-solid fa-hand-holding-heart text-warning fa-lg"></i>
							<h5 class="fw-bold m-0" style="color: var(--color-text-primary);">
								<fmt:message key="sobre.extensao.titulo" />
							</h5>
						</div>
						<p class="small text-secondary m-0" style="line-height: 1.6;">
							<fmt:message key="sobre.extensao.desc" />
						</p>
					</div>
				</div>
			</div>
		</section>

		<!-- Seção: Liderança / Coordenação Responsável (Figma #1006:52) -->
		<section id="coordenacao" class="container mb-5">
			<div class="mb-4">
				<span class="text-uppercase fw-bold small d-block mb-1" style="color: #059669; letter-spacing: 0.08em;">
					LIDERANÇA
				</span>
				<h2 class="fw-bold m-0" style="color: var(--color-secondary); font-size: 28px;">
					Coordenação Responsável
				</h2>
			</div>

			<div class="row g-4">
				<c:choose>
					<c:when test="${not empty coordenadores}">
						<c:forEach var="coord" items="${coordenadores}">
							<div class="col-md-6">
								<div class="card-portal p-4 h-100 d-flex gap-3 align-items-start">
									<div class="card-student-avatar-placeholder flex-shrink-0" style="width: 64px; height: 64px; font-size: 24px; margin: 0;">
										<i class="fa-solid fa-user-tie"></i>
									</div>
									<div>
										<span class="badge mb-2" style="background-color: var(--color-primary-subtle); color: var(--color-primary-dark); font-size: 11px; font-weight: 700;">
											COORDENADOR DO LABORATÓRIO
										</span>
										<h5 class="fw-bold mb-1" style="color: var(--color-text-primary);">
											<c:out value="${coord.nome}" />
										</h5>
										<p class="small text-secondary mb-0" style="line-height: 1.6;">
											<c:out value="${coord.minibio}" />
										</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<!-- Fallback conforme Figma -->
						<div class="col-md-6">
							<div class="card-portal p-4 h-100 d-flex gap-3 align-items-start">
								<div class="card-student-avatar-placeholder flex-shrink-0" style="width: 64px; height: 64px; font-size: 24px; margin: 0;">
									<i class="fa-solid fa-user-tie"></i>
								</div>
								<div>
									<span class="badge mb-2" style="background-color: var(--color-primary-subtle); color: var(--color-primary-dark); font-size: 11px; font-weight: 700;">
										COORDENADOR DO LABORATÓRIO
									</span>
									<h5 class="fw-bold mb-1" style="color: var(--color-text-primary);">
										Fábio Luiz Faria da Silva
									</h5>
									<p class="small text-secondary mb-0" style="line-height: 1.6;">
										Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.
									</p>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card-portal p-4 h-100 d-flex gap-3 align-items-start">
								<div class="card-student-avatar-placeholder flex-shrink-0" style="width: 64px; height: 64px; font-size: 24px; margin: 0;">
									<i class="fa-solid fa-user-tie"></i>
								</div>
								<div>
									<span class="badge mb-2" style="background-color: var(--color-primary-subtle); color: var(--color-primary-dark); font-size: 11px; font-weight: 700;">
										COORDENADOR DO LABORATÓRIO
									</span>
									<h5 class="fw-bold mb-1" style="color: var(--color-text-primary);">
										Rodrigo Cardoso
									</h5>
									<p class="small text-secondary mb-0" style="line-height: 1.6;">
										Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.
									</p>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
