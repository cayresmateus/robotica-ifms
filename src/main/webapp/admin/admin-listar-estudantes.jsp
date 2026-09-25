<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.estudantes.titulo" /> — <fmt:message key="app.nome" /></title>

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
						<fmt:message key="admin.estudantes.titulo" />
					</h2>
				</div>
				<a href="${pageContext.request.contextPath}/admin/estudantes?acao=novo" class="btn-portal-primary">
					<i class="fa-solid fa-user-plus"></i>
					<fmt:message key="admin.estudantes.novo" />
				</a>
			</div>

			<!-- Mensagens de Alerta (Feedback visual) -->
			<c:if test="${mensagemSucesso != null}">
				<div class="alert-portal alert-portal-success">
					<i class="fa-solid fa-circle-check fa-lg"></i>
					<span><fmt:message key="${mensagemSucesso}" /></span>
				</div>
			</c:if>

			<!-- Tabela de Estudantes -->
			<div class="card-portal overflow-hidden">
				<div class="table-responsive">
					<table class="table-portal mb-0">
						<thead>
							<tr>
								<th style="width: 70px;">ID</th>
								<th style="width: 80px;"><fmt:message key="admin.estudantes.tabela.foto" /></th>
								<th><fmt:message key="admin.estudantes.tabela.nome" /></th>
								<th><fmt:message key="admin.estudantes.tabela.minibio" /></th>
								<th class="text-end" style="width: 120px;"><fmt:message key="admin.estudantes.tabela.acoes" /></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty listaEstudantes}">
									<tr>
										<td colspan="5" class="text-center py-4 text-muted">
											<fmt:message key="estudantes.nenhum" />
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="est" items="${listaEstudantes}">
										<tr>
											<td class="text-muted fw-bold">#<c:out value="${est.id}" /></td>
											<td>
												<c:choose>
													<c:when test="${not empty est.foto && est.foto.startsWith('http')}">
														<img src="${est.foto}" alt="${est.nome}" class="avatar-student" style="width: 44px; height: 44px;">
													</c:when>
													<c:otherwise>
														<div class="avatar-placeholder" title="Perfil sem foto">
															<i class="fa-solid fa-user"></i>
														</div>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<strong class="text-dark"><c:out value="${est.nome}" /></strong>
											</td>
											<td class="text-secondary small" style="max-width: 450px;">
												<c:out value="${est.minibio}" />
											</td>
											<td class="text-end">
												<a class="btn-portal-danger" 
												   href="${pageContext.request.contextPath}/admin/estudantes?acao=apagar&id=${est.id}"
												   onclick="return confirm('<fmt:message key="admin.estudantes.confirmar.excluir" />');">
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
