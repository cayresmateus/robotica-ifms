<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.participacoes.form.titulo" /> — <fmt:message key="app.nome" /></title>

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
		<div class="container" style="max-width: 720px;">
			<!-- Botão de Retorno -->
			<div class="mb-3">
				<a href="${pageContext.request.contextPath}/admin/participacoes?acao=listar" class="btn-portal-outline btn-sm">
					<i class="fa-solid fa-arrow-left"></i>
					<fmt:message key="btn.voltar" />
				</a>
			</div>

			<!-- Card com Formulário de Cadastro -->
			<div class="card-portal p-4 p-md-5">
				<div class="d-flex align-items-center gap-3 mb-4">
					<div class="stat-icon orange" style="width: 44px; height: 44px; font-size: 20px;">
						<i class="fa-solid fa-link"></i>
					</div>
					<div>
						<h3 class="fw-bold m-0" style="color: var(--color-secondary);">
							<fmt:message key="admin.participacoes.form.titulo" />
						</h3>
						<span class="small text-muted">Vincule um estudante a um projeto ou atividade do laboratório.</span>
					</div>
				</div>

				<form action="${pageContext.request.contextPath}/admin/participacoes?acao=inserir" method="post">
					<!-- Selecionar Estudante -->
					<div class="mb-3">
						<label for="estudanteId" class="form-label-portal">
							<fmt:message key="admin.participacoes.form.estudante" /> *
						</label>
						<select class="form-select-portal" id="estudanteId" name="estudanteId" required>
							<option value="">Selecione um estudante...</option>
							<c:forEach var="e" items="${estudantes}">
								<option value="${e.id}"><c:out value="${e.nome}" /></option>
							</c:forEach>
						</select>
					</div>

					<!-- Selecionar Atividade -->
					<div class="mb-3">
						<label for="atividadeId" class="form-label-portal">
							<fmt:message key="admin.participacoes.form.atividade" /> *
						</label>
						<select class="form-select-portal" id="atividadeId" name="atividadeId" required>
							<option value="">Selecione uma atividade...</option>
							<c:forEach var="a" items="${atividades}">
								<option value="${a.id}">[<c:out value="${a.tipo}" />] <c:out value="${a.titulo}" /></option>
							</c:forEach>
						</select>
					</div>

					<!-- Função -->
					<div class="mb-3">
						<label for="funcao" class="form-label-portal">
							<fmt:message key="admin.participacoes.form.funcao" />
						</label>
						<input type="text" class="form-control-portal" id="funcao" name="funcao" 
						       placeholder="Ex: Programador de Firmware, Bolsista PICTEC, Instrutor">
					</div>

					<!-- Descrição da Contribuição -->
					<div class="mb-4">
						<label for="descricaoContribuicao" class="form-label-portal">
							<fmt:message key="admin.participacoes.form.contribuicao" />
						</label>
						<textarea class="form-control-portal" id="descricaoContribuicao" name="descricaoContribuicao" rows="3"
						          placeholder="Descreva o papel e as entregas realizadas pelo estudante..."></textarea>
					</div>

					<!-- Botões de Ação -->
					<div class="d-flex align-items-center justify-content-end gap-2 pt-3 border-top">
						<a href="${pageContext.request.contextPath}/admin/participacoes?acao=listar" class="btn-portal-outline">
							<fmt:message key="btn.cancelar" />
						</a>
						<button type="submit" class="btn-portal-primary">
							<i class="fa-solid fa-check"></i>
							<fmt:message key="admin.participacoes.form.salvar" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
