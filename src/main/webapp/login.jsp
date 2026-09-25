<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="${sessionScope.currentLocale != null ? sessionScope.currentLocale : 'pt-BR'}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><fmt:message key="login.titulo" /> — <fmt:message key="app.nome" /></title>

	<!-- Bootstrap & Ícones -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

	<!-- Tokens CSS (Figma portal-robo) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tokens.css">
</head>
<body class="login-page-bg">

	<div class="login-card-figma">
		<!-- Ícone Superior em Círculo Verde (Figma #1012:680) -->
		<div class="login-icon-badge">
			<i class="fa-solid fa-user-shield"></i>
		</div>

		<!-- Título & Subtítulo (Figma #1012:683) -->
		<h2 class="fw-bold mb-1" style="color: var(--color-text-primary); font-size: 24px;">
			<fmt:message key="login.titulo" />
		</h2>
		<p class="small text-secondary mb-4" style="line-height: 1.5;">
			<fmt:message key="login.subtitulo" />
		</p>

		<!-- Mensagem de Erro (se houver) -->
		<c:if test="${not empty erro}">
			<div class="alert alert-danger py-2 small mb-3 text-start" role="alert">
				<i class="fa-solid fa-triangle-exclamation me-1"></i>
				<fmt:message key="${erro}" />
			</div>
		</c:if>

		<!-- Formulário de Autenticação (Figma #1012:687) -->
		<form action="${pageContext.request.contextPath}/login" method="post" class="text-start">
			<!-- Campo: E-mail Institucional -->
			<div class="mb-3">
				<label for="email" class="form-label-portal text-uppercase" style="font-size: 11.5px; letter-spacing: 0.04em;">
					<fmt:message key="login.label.email" />
				</label>
				<div class="input-group">
					<span class="input-group-text bg-white border-end-0 text-secondary" style="border-color: var(--color-border-subtle);">
						<i class="fa-regular fa-envelope"></i>
					</span>
					<input type="email" id="email" name="email" class="form-control form-control-portal border-start-0 ps-0" placeholder="usuario@ifms.edu.br" value="${param.email != null ? param.email : 'admin@ifms.edu.br'}" required>
				</div>
			</div>

			<!-- Campo: Senha -->
			<div class="mb-4">
				<label for="senha" class="form-label-portal text-uppercase" style="font-size: 11.5px; letter-spacing: 0.04em;">
					<fmt:message key="login.label.senha" />
				</label>
				<div class="input-group">
					<span class="input-group-text bg-white border-end-0 text-secondary" style="border-color: var(--color-border-subtle);">
						<i class="fa-solid fa-lock"></i>
					</span>
					<input type="password" id="senha" name="senha" class="form-control form-control-portal border-start-0 ps-0" placeholder="••••••••" value="admin123" required>
				</div>
			</div>

			<!-- Botão de Acesso Vermelho IFMS -->
			<button type="submit" class="btn-login-red mb-3">
				<i class="fa-solid fa-arrow-right-to-bracket"></i>
				<span><fmt:message key="login.btn.entrar" /></span>
			</button>
		</form>

		<!-- Link de Retorno à Home (Figma #1012:708) -->
		<div class="pt-2">
			<a href="${pageContext.request.contextPath}/inicio" class="text-decoration-none small text-secondary fw-semibold d-inline-flex align-items-center gap-1">
				<i class="fa-solid fa-arrow-left fa-xs"></i>
				<span><fmt:message key="login.link.voltar" /></span>
			</a>
		</div>
	</div>

</body>
</html>
