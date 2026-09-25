<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.atividades.titulo" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body>

	<jsp:include page="/shared/header.jsp">
		<jsp:param name="pagina" value="admin" />
	</jsp:include>

	<main class="main-content py-5">
		<div class="container">
			<!-- Cabeçalho Administrativo -->
			<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
				<div>
					<span class="badge-portal badge-tipo mb-1">
						<i class="fa-solid fa-lock-open me-1"></i>
						Área de Gestão
					</span>
					<h2 class="fw-bold m-0" style="color: var(--color-secondary);">
						<fmt:message key="admin.atividades.titulo" />
					</h2>
				</div>
				<a href="${pageContext.request.contextPath}/admin/atividades?acao=novo" class="btn-portal-primary">
					<i class="fa-solid fa-plus"></i>
					<fmt:message key="admin.atividades.nova" />
				</a>
			</div>

			<!-- Mensagens de Alerta -->
			<c:if test="${mensagemSucesso != null}">
				<div class="alert-portal alert-portal-success">
					<i class="fa-solid fa-circle-check fa-lg"></i>
					<span><fmt:message key="${mensagemSucesso}" /></span>
				</div>
			</c:if>

			<!-- Tabela de Atividades -->
			<div class="card-portal overflow-hidden">
				<div class="table-responsive">
					<table class="table-portal mb-0">
						<thead>
							<tr>
								<th style="width: 70px;">ID</th>
								<th><fmt:message key="admin.atividades.tabela.titulo" /></th>
								<th><fmt:message key="admin.atividades.tabela.tipo" /></th>
								<th><fmt:message key="admin.atividades.tabela.periodos" /></th>
								<th><fmt:message key="admin.atividades.tabela.situacao" /></th>
								<th><fmt:message key="admin.atividades.tabela.datas" /></th>
								<th class="text-end" style="width: 120px;"><fmt:message key="admin.atividades.tabela.acoes" /></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty listaAtividades}">
									<tr>
										<td colspan="7" class="text-center py-4 text-muted">
											<fmt:message key="atividades.nenhuma" />
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="ativ" items="${listaAtividades}">
										<tr>
											<td class="text-muted fw-bold">#<c:out value="${ativ.id}" /></td>
											<td>
												<a href="${pageContext.request.contextPath}/atividade-detalhes?id=${ativ.id}" class="fw-bold text-decoration-none text-dark">
													<c:out value="${ativ.titulo}" />
												</a>
											</td>
											<td>
												<span class="badge-portal badge-tipo">
													<c:out value="${ativ.tipo}" />
												</span>
											</td>
											<td>
												<div class="d-flex flex-wrap gap-1">
													<c:choose>
														<c:when test="${not empty ativ.periodos}">
															<c:forEach var="p" items="${ativ.periodos}">
																<span class="badge-periodo"><c:out value="${p.rotulo}" /></span>
															</c:forEach>
														</c:when>
														<c:otherwise>—</c:otherwise>
													</c:choose>
												</div>
											</td>
											<td>
												<span class="badge-portal ${ativ.situacao == 'Concluída' ? 'badge-situacao-concluida' : (ativ.situacao == 'Em andamento' ? 'badge-situacao-andamento' : 'badge-situacao-planejada')}">
													<c:out value="${ativ.situacao}" />
												</span>
											</td>
											<td class="small text-secondary">
												<c:out value="${ativ.dataInicio}" />
												<c:if test="${not empty ativ.dataFim}">
													— <c:out value="${ativ.dataFim}" />
												</c:if>
											</td>
											<td class="text-end">
												<a class="btn-portal-danger" 
												   href="${pageContext.request.contextPath}/admin/atividades?acao=apagar&id=${ativ.id}"
												   onclick="return confirm('<fmt:message key="admin.atividades.confirmar.excluir" />');">
													<i class="fa-solid fa-trash-can"></i>
													<fmt:message key="btn.excluir" />
												</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
