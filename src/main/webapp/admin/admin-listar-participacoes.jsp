<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.participacoes.titulo" /> — <fmt:message key="app.nome" /></title>

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
						<fmt:message key="admin.participacoes.titulo" />
					</h2>
				</div>
				<a href="${pageContext.request.contextPath}/admin/participacoes?acao=novo" class="btn-portal-primary">
					<i class="fa-solid fa-user-plus"></i>
					<fmt:message key="admin.participacoes.nova" />
				</a>
			</div>

			<!-- Mensagens de Alerta -->
			<c:if test="${mensagemSucesso != null}">
				<div class="alert-portal alert-portal-success">
					<i class="fa-solid fa-circle-check fa-lg"></i>
					<span><fmt:message key="${mensagemSucesso}" /></span>
				</div>
			</c:if>

			<!-- Tabela de Participações -->
			<div class="card-portal overflow-hidden">
				<div class="table-responsive">
					<table class="table-portal mb-0">
						<thead>
							<tr>
								<th><fmt:message key="admin.participacoes.tabela.estudante" /></th>
								<th><fmt:message key="admin.participacoes.tabela.atividade" /></th>
								<th><fmt:message key="admin.participacoes.tabela.funcao" /></th>
								<th><fmt:message key="admin.participacoes.tabela.contribuicao" /></th>
								<th class="text-end" style="width: 120px;"><fmt:message key="admin.participacoes.tabela.acoes" /></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty listaParticipacoes}">
									<tr>
										<td colspan="5" class="text-center py-4 text-muted">
											Nenhuma participação vinculada ainda.
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="part" items="${listaParticipacoes}">
										<tr>
											<td>
												<div class="d-flex align-items-center gap-2">
													<div class="avatar-placeholder" style="width: 36px; height: 36px; font-size: 14px;">
														<c:out value="${part.estudante.nome.substring(0,1)}" />
													</div>
													<strong class="text-dark"><c:out value="${part.estudante.nome}" /></strong>
												</div>
											</td>
											<td>
												<span class="badge-portal badge-tipo mb-1" style="font-size: 11px;">
													<c:out value="${part.atividade.tipo}" />
												</span>
												<div class="fw-bold text-dark">
													<c:out value="${part.atividade.titulo}" />
												</div>
											</td>
											<td>
												<span class="badge bg-light text-dark border">
													<c:out value="${part.funcao}" />
												</span>
											</td>
											<td class="small text-secondary" style="max-width: 400px;">
												<c:out value="${part.descricaoContribuicao}" />
											</td>
											<td class="text-end">
												<a class="btn-portal-danger" 
												   href="${pageContext.request.contextPath}/admin/participacoes?acao=apagar&estudanteId=${part.estudante.id}&atividadeId=${part.atividade.id}"
												   onclick="return confirm('<fmt:message key="admin.participacoes.confirmar.excluir" />');">
													<i class="fa-solid fa-link-slash"></i>
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
