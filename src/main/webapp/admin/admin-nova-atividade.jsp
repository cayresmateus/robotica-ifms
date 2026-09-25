<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.atividades.form.titulo" /> — <fmt:message key="app.nome" /></title>

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
		<div class="container" style="max-width: 820px;">
			<!-- Botão de Retorno -->
			<div class="mb-3">
				<a href="${pageContext.request.contextPath}/admin/atividades?acao=listar" class="btn-portal-outline btn-sm">
					<i class="fa-solid fa-arrow-left"></i>
					<fmt:message key="btn.voltar" />
				</a>
			</div>

			<!-- Card com Formulário de Cadastro -->
			<div class="card-portal p-4 p-md-5">
				<div class="d-flex align-items-center gap-3 mb-4">
					<div class="stat-icon blue" style="width: 44px; height: 44px; font-size: 20px;">
						<i class="fa-solid fa-plus-circle"></i>
					</div>
					<div>
						<h3 class="fw-bold m-0" style="color: var(--color-secondary);">
							<fmt:message key="admin.atividades.form.titulo" />
						</h3>
						<span class="small text-muted">Registre um novo projeto, estágio, oficina ou competição.</span>
					</div>
				</div>

				<form action="${pageContext.request.contextPath}/admin/atividades?acao=inserir" method="post">
					<!-- Título -->
					<div class="mb-3">
						<label for="titulo" class="form-label-portal">
							<fmt:message key="admin.atividades.form.titulo.label" /> *
						</label>
						<input type="text" class="form-control-portal" id="titulo" name="titulo" required 
						       placeholder="Ex: Projeto Negrótica 2026">
					</div>

					<div class="row g-3 mb-3">
						<!-- Tipo -->
						<div class="col-md-6">
							<label for="tipo" class="form-label-portal">
								<fmt:message key="admin.atividades.form.tipo" /> *
							</label>
							<select class="form-select-portal" id="tipo" name="tipo" required>
								<option value="Projeto"><fmt:message key="tipo.projeto" /></option>
								<option value="Estágio"><fmt:message key="tipo.estagio" /></option>
								<option value="Oficina"><fmt:message key="tipo.oficina" /></option>
								<option value="Tarefa"><fmt:message key="tipo.tarefa" /></option>
								<option value="Palestra"><fmt:message key="tipo.palestra" /></option>
								<option value="Evento"><fmt:message key="tipo.evento" /></option>
								<option value="Competição"><fmt:message key="tipo.competicao" /></option>
								<option value="Visita"><fmt:message key="tipo.visita" /></option>
							</select>
						</div>

						<!-- Situação -->
						<div class="col-md-6">
							<label for="situacao" class="form-label-portal">
								<fmt:message key="admin.atividades.form.situacao" /> *
							</label>
							<select class="form-select-portal" id="situacao" name="situacao" required>
								<option value="Em andamento"><fmt:message key="situacao.andamento" /></option>
								<option value="Planejada"><fmt:message key="situacao.planejada" /></option>
								<option value="Concluída"><fmt:message key="situacao.concluida" /></option>
							</select>
						</div>
					</div>

					<div class="row g-3 mb-3">
						<!-- Data Início -->
						<div class="col-md-6">
							<label for="dataInicio" class="form-label-portal">
								<fmt:message key="admin.atividades.form.data_inicio" /> *
							</label>
							<input type="date" class="form-control-portal" id="dataInicio" name="dataInicio" required>
						</div>

						<!-- Data Fim -->
						<div class="col-md-6">
							<label for="dataFim" class="form-label-portal">
								<fmt:message key="admin.atividades.form.data_fim" />
							</label>
							<input type="date" class="form-control-portal" id="dataFim" name="dataFim">
						</div>
					</div>

					<!-- Coordenador -->
					<div class="mb-3">
						<label for="coordenadorId" class="form-label-portal">
							<fmt:message key="admin.atividades.form.coordenador" /> *
						</label>
						<select class="form-select-portal" id="coordenadorId" name="coordenadorId" required>
							<c:forEach var="c" items="${coordenadores}">
								<option value="${c.id}"><c:out value="${c.nome}" /></option>
							</c:forEach>
						</select>
					</div>

					<!-- Períodos Letivos (Associação obrigatória conforme modelo relacional) -->
					<div class="mb-4">
						<label class="form-label-portal d-block">
							<fmt:message key="admin.atividades.form.periodos" /> *
						</label>
						<div class="d-flex flex-wrap gap-3 p-3 rounded bg-light border">
							<c:forEach var="p" items="${periodos}">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="periodos" value="${p.id}" id="per_${p.id}">
									<label class="form-check-label fw-bold text-dark small" for="per_${p.id}">
										<c:out value="${p.rotulo}" />
									</label>
								</div>
							</c:forEach>
						</div>
						<span class="small text-muted mt-1 d-block">Uma atividade pode ocorrer em um ou mais semestres.</span>
					</div>

					<!-- Descrição -->
					<div class="mb-4">
						<label for="descricao" class="form-label-portal">
							<fmt:message key="admin.atividades.form.descricao" /> *
						</label>
						<textarea class="form-control-portal" id="descricao" name="descricao" rows="4" required
						          placeholder="Detalhes sobre a proposta, objetivos e metodologias da atividade..."></textarea>
					</div>

					<!-- Botões de Ação -->
					<div class="d-flex align-items-center justify-content-end gap-2 pt-3 border-top">
						<a href="${pageContext.request.contextPath}/admin/atividades?acao=listar" class="btn-portal-outline">
							<fmt:message key="btn.cancelar" />
						</a>
						<button type="submit" class="btn-portal-primary">
							<i class="fa-solid fa-check"></i>
							<fmt:message key="admin.atividades.form.salvar" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
