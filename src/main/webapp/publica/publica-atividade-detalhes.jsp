<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><c:out value="${atividade.titulo}" /> — <fmt:message key="app.nome" /></title>

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

	<main class="main-content py-5">
		<div class="container">
			<!-- Botão de Retorno -->
			<div class="mb-4">
				<a href="${pageContext.request.contextPath}/atividades" class="btn-portal-outline btn-sm">
					<i class="fa-solid fa-arrow-left"></i>
					<fmt:message key="detalhes.voltar" />
				</a>
			</div>

			<!-- Card Principal de Detalhes -->
			<div class="card-portal p-4 p-md-5 mb-5">
				<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
					<div>
						<span class="badge-portal badge-tipo mb-2">
							<c:out value="${atividade.tipo}" />
						</span>
						<h2 class="fw-bold mb-1" style="color: var(--color-secondary);">
							<c:out value="${atividade.titulo}" />
						</h2>
					</div>
					<span class="badge-portal ${atividade.situacao == 'Concluída' ? 'badge-situacao-concluida' : (atividade.situacao == 'Em andamento' ? 'badge-situacao-andamento' : 'badge-situacao-planejada')} fs-6 px-3 py-2">
						<i class="fa-solid fa-circle-dot me-1"></i>
						<c:out value="${atividade.situacao}" />
					</span>
				</div>

				<hr class="my-4 border-secondary opacity-25">

				<!-- Meta Informações em Grid -->
				<div class="row g-4 mb-4">
					<div class="col-md-4">
						<div class="p-3 rounded bg-light border">
							<div class="text-muted small mb-1">
								<i class="fa-solid fa-calendar-check me-1 text-primary"></i>
								<fmt:message key="detalhes.periodos" />
							</div>
							<div class="fw-bold text-dark">
								<c:choose>
									<c:when test="${not empty atividade.periodos}">
										<c:forEach var="p" items="${atividade.periodos}">
											<span class="badge-periodo me-1"><c:out value="${p.rotulo}" /></span>
										</c:forEach>
									</c:when>
									<c:otherwise>—</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="p-3 rounded bg-light border">
							<div class="text-muted small mb-1">
								<i class="fa-regular fa-clock me-1 text-success"></i>
								<fmt:message key="detalhes.datas" />
							</div>
							<div class="fw-bold text-dark">
								<c:out value="${atividade.dataInicio}" />
								<c:if test="${not empty atividade.dataFim}">
									— <c:out value="${atividade.dataFim}" />
								</c:if>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="p-3 rounded bg-light border">
							<div class="text-muted small mb-1">
								<i class="fa-solid fa-user-tie me-1 text-info"></i>
								<fmt:message key="detalhes.coordenador" />
							</div>
							<div class="fw-bold text-dark">
								<c:choose>
									<c:when test="${not empty atividade.coordenador}">
										<c:out value="${atividade.coordenador.nome}" />
									</c:when>
									<c:otherwise>IFMS</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>

				<!-- Descrição Completa -->
				<div>
					<h5 class="fw-bold mb-2" style="color: var(--color-secondary);">
						<fmt:message key="detalhes.descricao" />
					</h5>
					<p class="text-secondary" style="line-height: 1.8; font-size: 15px;">
						<c:out value="${atividade.descricao}" />
					</p>
				</div>
			</div>

			<!-- Estudantes Participantes -->
			<div class="mb-5">
				<div class="mb-3">
					<h3 class="fw-bold m-0" style="color: var(--color-secondary);">
						<i class="fa-solid fa-people-group me-2 text-primary"></i>
						<fmt:message key="detalhes.participantes.titulo" />
					</h3>
					<p class="text-secondary small m-0">
						<fmt:message key="detalhes.participantes.subtitulo" />
					</p>
				</div>

				<c:choose>
					<c:when test="${empty atividade.participacoes}">
						<div class="card-portal p-4 text-center">
							<i class="fa-solid fa-user-slash fa-2x text-muted mb-2"></i>
							<p class="text-secondary m-0"><fmt:message key="detalhes.participantes.nenhum" /></p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="card-portal overflow-hidden">
							<div class="table-responsive">
								<table class="table-portal mb-0">
									<thead>
										<tr>
											<th><fmt:message key="detalhes.tabela.estudante" /></th>
											<th><fmt:message key="detalhes.tabela.funcao" /></th>
											<th><fmt:message key="detalhes.tabela.contribuicao" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="part" items="${atividade.participacoes}">
											<tr>
												<td>
													<div class="d-flex align-items-center gap-3">
														<c:choose>
															<c:when test="${not empty part.estudante.foto && part.estudante.foto.startsWith('http')}">
																<img src="${part.estudante.foto}" alt="${part.estudante.nome}" class="avatar-student" style="width: 44px; height: 44px;">
															</c:when>
															<c:otherwise>
																<div class="avatar-placeholder" title="Perfil sem foto">
																	<i class="fa-solid fa-user"></i>
																</div>
															</c:otherwise>
														</c:choose>
														<div>
															<strong class="d-block text-dark"><c:out value="${part.estudante.nome}" /></strong>
															<span class="small text-muted"><c:out value="${part.estudante.minibio}" /></span>
														</div>
													</div>
												</td>
												<td>
													<span class="badge-portal badge-tipo">
														<i class="fa-solid fa-id-badge me-1"></i>
														<c:out value="${part.funcao}" />
													</span>
												</td>
												<td class="text-secondary small" style="line-height: 1.5;">
													<c:out value="${part.descricaoContribuicao}" />
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
