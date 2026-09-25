<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="admin.estudantes.form.titulo" /> — <fmt:message key="app.nome" /></title>

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
				<a href="${pageContext.request.contextPath}/admin/estudantes?acao=listar" class="btn-portal-outline btn-sm">
					<i class="fa-solid fa-arrow-left"></i>
					<fmt:message key="btn.voltar" />
				</a>
			</div>

			<!-- Card com Formulário de Cadastro -->
			<div class="card-portal p-4 p-md-5">
				<div class="d-flex align-items-center gap-3 mb-4">
					<div class="stat-icon green" style="width: 44px; height: 44px; font-size: 20px;">
						<i class="fa-solid fa-user-plus"></i>
					</div>
					<div>
						<h3 class="fw-bold m-0" style="color: var(--color-secondary);">
							<fmt:message key="admin.estudantes.form.titulo" />
						</h3>
						<span class="small text-muted">Preencha as informações para registrar um novo integrante.</span>
					</div>
				</div>

				<form action="${pageContext.request.contextPath}/admin/estudantes?acao=inserir" method="post">
					<!-- Nome -->
					<div class="mb-3">
						<label for="nome" class="form-label-portal">
							<fmt:message key="admin.estudantes.form.nome" /> *
						</label>
						<input type="text" class="form-control-portal" id="nome" name="nome" required 
						       placeholder="Ex: Mateus Cayres">
					</div>

					<!-- Minibio -->
					<div class="mb-3">
						<label for="minibio" class="form-label-portal">
							<fmt:message key="admin.estudantes.form.minibio" />
						</label>
						<textarea class="form-control-portal" id="minibio" name="minibio" rows="3" 
						          placeholder="Breve descrição da atuação do estudante no laboratório..."></textarea>
					</div>

					<!-- Foto -->
					<div class="mb-4">
						<label for="foto" class="form-label-portal">
							<fmt:message key="admin.estudantes.form.foto" />
						</label>
						<input type="text" class="form-control-portal" id="foto" name="foto" 
						       placeholder="https://exemplo.com/foto.jpg ou nome_arquivo.jpg">
						<span class="small text-muted mt-1 d-block">Pode ser uma URL de imagem externa ou caminho local.</span>
					</div>

					<!-- Botões de Ação -->
					<div class="d-flex align-items-center justify-content-end gap-2 pt-3 border-top">
						<a href="${pageContext.request.contextPath}/admin/estudantes?acao=listar" class="btn-portal-outline">
							<fmt:message key="admin.estudantes.form.cancelar" />
						</a>
						<button type="submit" class="btn-portal-primary">
							<i class="fa-solid fa-check"></i>
							<fmt:message key="admin.estudantes.form.salvar" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<jsp:include page="/shared/footer.jsp" />

</body>
</html>
