<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<header class="navbar-portal sticky-top">
	<div class="container">
		<div class="d-flex align-items-center justify-content-between w-100 flex-wrap gap-3">
			<!-- Logotipo & Identidade Visual (Figma #1001:262) -->
			<a class="navbar-brand-portal" href="${pageContext.request.contextPath}/inicio">
				<div class="brand-icon">
					<i class="fa-solid fa-robot"></i>
				</div>
				<div class="d-flex align-items-center gap-2">
					<span style="color: var(--color-secondary); font-size: 20px; font-weight: 800; letter-spacing: -0.02em;">Portal Robótica</span>
					<span class="badge" style="background: rgba(16, 185, 129, 0.12); color: #059669; font-weight: 800; font-size: 11px; padding: 4px 8px; border-radius: 6px;">IFMS CG</span>
				</div>
			</a>

			<!-- Navegação Principal (Figma #1001:269) -->
			<nav class="d-flex align-items-center gap-1 flex-wrap">
				<a class="nav-link-portal ${param.pagina == 'inicio' ? 'active' : ''}" href="${pageContext.request.contextPath}/inicio">
					<fmt:message key="nav.inicio" />
				</a>
				<a class="nav-link-portal ${param.pagina == 'sobre' ? 'active' : ''}" href="${pageContext.request.contextPath}/sobre">
					<fmt:message key="nav.sobre" />
				</a>
				<a class="nav-link-portal ${param.pagina == 'atividades' ? 'active' : ''}" href="${pageContext.request.contextPath}/atividades">
					<fmt:message key="nav.atividades" />
				</a>
				<a class="nav-link-portal ${param.pagina == 'conquistas' ? 'active' : ''}" href="${pageContext.request.contextPath}/conquistas">
					<fmt:message key="nav.conquistas" />
				</a>
				<a class="nav-link-portal ${param.pagina == 'estudantes' ? 'active' : ''}" href="${pageContext.request.contextPath}/estudantes">
					<fmt:message key="nav.estudantes" />
				</a>
			</nav>

			<!-- Ações e Suporte i18n (Figma #1001:281) -->
			<div class="d-flex align-items-center gap-2">
				<!-- Seletor de Idiomas (4 idiomas da N1) -->
				<div class="dropdown">
					<button class="btn btn-sm btn-light border dropdown-toggle fw-semibold" type="button" id="langDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 8px; padding: 6px 12px; font-size: 13px; color: var(--color-text-secondary);">
						<i class="fa-solid fa-globe me-1 text-primary"></i>
						<c:choose>
							<c:when test="${sessionScope.currentLocale == 'en_US'}">🇺🇸 EN</c:when>
							<c:when test="${sessionScope.currentLocale == 'es_ES'}">🇪🇸 ES</c:when>
							<c:when test="${sessionScope.currentLocale == 'fr_FR'}">🇫🇷 FR</c:when>
							<c:otherwise>🇧🇷 PT</c:otherwise>
						</c:choose>
					</button>
					<ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="langDropdown" style="border-radius: 8px; font-size: 13px;">
						<li><a class="dropdown-item ${sessionScope.currentLocale == null || sessionScope.currentLocale == 'pt_BR' ? 'fw-bold text-success' : ''}" href="${pageContext.request.contextPath}/I18nControle?lingua=pt_BR">🇧🇷 Português (PT)</a></li>
						<li><a class="dropdown-item ${sessionScope.currentLocale == 'en_US' ? 'fw-bold text-success' : ''}" href="${pageContext.request.contextPath}/I18nControle?lingua=en_US">🇺🇸 English (EN)</a></li>
						<li><a class="dropdown-item ${sessionScope.currentLocale == 'es_ES' ? 'fw-bold text-success' : ''}" href="${pageContext.request.contextPath}/I18nControle?lingua=es_ES">🇪🇸 Español (ES)</a></li>
						<li><a class="dropdown-item ${sessionScope.currentLocale == 'fr_FR' ? 'fw-bold text-success' : ''}" href="${pageContext.request.contextPath}/I18nControle?lingua=fr_FR">🇫🇷 Français (FR)</a></li>
					</ul>
				</div>

				<!-- Botão de Gestão Vermelho IFMS (Figma #1001:285) -->
				<div class="btn-group">
					<a href="${pageContext.request.contextPath}/login" class="btn-portal-danger py-2 px-3 fw-bold" style="border-radius: 8px; background-color: var(--color-danger-dark); box-shadow: 0 2px 8px rgba(183, 54, 54, 0.3);">
						<i class="fa-solid fa-lock fa-sm"></i>
						<span><fmt:message key="nav.admin" /></span>
					</a>
					<button type="button" class="btn btn-sm dropdown-toggle dropdown-toggle-split text-white" style="background-color: var(--color-danger-dark); border-left: 1px solid rgba(255,255,255,0.3); border-radius: 0 8px 8px 0;" data-bs-toggle="dropdown" aria-expanded="false">
						<span class="visually-hidden">Toggle Dropdown</span>
					</button>
					<ul class="dropdown-menu dropdown-menu-end shadow-sm" style="border-radius: var(--radius-md); font-size: 13px;">
						<li>
							<a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/estudantes?acao=listar">
								<i class="fa-solid fa-users me-2 text-primary"></i>
								<fmt:message key="nav.admin.estudantes" />
							</a>
						</li>
						<li>
							<a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/atividades?acao=listar">
								<i class="fa-solid fa-list-check me-2 text-success"></i>
								<fmt:message key="nav.admin.atividades" />
							</a>
						</li>
						<li>
							<a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/participacoes?acao=listar">
								<i class="fa-solid fa-handshake me-2 text-warning"></i>
								<fmt:message key="nav.admin.participacoes" />
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>
