<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<footer class="footer-portal">
	<div class="container">
		<!-- Grade de 4 Colunas do Figma (#1001:179) -->
		<div class="row gy-4 gx-lg-5">
			<!-- Coluna 1: Marca & Social -->
			<div class="col-lg-4 col-md-6">
				<div class="d-flex align-items-center gap-3 mb-3">
					<div class="brand-icon" style="width: 40px; height: 40px; font-size: 18px; background: rgba(255, 255, 255, 0.2);">
						<i class="fa-solid fa-robot"></i>
					</div>
					<div>
						<h5 class="m-0 text-white fw-bold" style="font-size: 18px;">Portal Robótica IFMS</h5>
						<span class="small" style="color: #A7F3D0; font-weight: 600;">Campus Campo Grande</span>
					</div>
				</div>
				<p class="small mb-3" style="color: #E2E8F0; line-height: 1.6;">
					Instituto Federal de Educação, Ciência e Tecnologia de Mato Grosso do Sul — Campus Campo Grande.
				</p>
				<div class="d-flex align-items-center gap-2">
					<a href="https://www.instagram.com/robotican.cg/" target="_blank" rel="noopener noreferrer" class="instagram-btn" title="Instagram Oficial">
						<i class="fa-brands fa-instagram fa-lg"></i>
						<span>@robotican.cg</span>
					</a>
					<a href="https://github.com" target="_blank" class="btn btn-sm btn-outline-light rounded-circle" style="width: 34px; height: 34px; display: inline-flex; align-items: center; justify-content: center;" title="Repositório do Projeto">
						<i class="fa-brands fa-github"></i>
					</a>
				</div>
			</div>

			<!-- Coluna 2: Navegação -->
			<div class="col-lg-2 col-md-6 col-6">
				<h6 class="text-uppercase fw-bold mb-3" style="color: #A7F3D0; font-size: 13px; letter-spacing: 0.05em;">
					<fmt:message key="footer.col.navegacao" />
				</h6>
				<ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
					<li><a href="${pageContext.request.contextPath}/inicio"><fmt:message key="nav.inicio" /></a></li>
					<li><a href="${pageContext.request.contextPath}/sobre"><fmt:message key="nav.sobre" /></a></li>
					<li><a href="${pageContext.request.contextPath}/atividades"><fmt:message key="nav.atividades" /></a></li>
					<li><a href="${pageContext.request.contextPath}/conquistas"><fmt:message key="nav.conquistas" /></a></li>
					<li><a href="${pageContext.request.contextPath}/estudantes"><fmt:message key="nav.estudantes" /></a></li>
				</ul>
			</div>

			<!-- Coluna 3: Acadêmico -->
			<div class="col-lg-3 col-md-6 col-6">
				<h6 class="text-uppercase fw-bold mb-3" style="color: #A7F3D0; font-size: 13px; letter-spacing: 0.05em;">
					<fmt:message key="footer.col.academico" />
				</h6>
				<ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
					<li><span class="text-white-50">TSI — IFMS</span></li>
					<li><span class="text-white-50">Linguagem de Prog. II</span></li>
					<li><a href="${pageContext.request.contextPath}/sobre#coordenacao"><fmt:message key="footer.link.coordenacao" /></a></li>
					<li><a href="${pageContext.request.contextPath}/login" style="color: #FECACA;"><i class="fa-solid fa-lock fa-xs me-1"></i> <fmt:message key="nav.admin" /></a></li>
				</ul>
			</div>

			<!-- Coluna 4: Contato & Endereço -->
			<div class="col-lg-3 col-md-6">
				<h6 class="text-uppercase fw-bold mb-3" style="color: #A7F3D0; font-size: 13px; letter-spacing: 0.05em;">
					<fmt:message key="footer.col.contato" />
				</h6>
				<div class="small d-flex flex-column gap-2" style="color: #E2E8F0;">
					<div class="d-flex align-items-start gap-2">
						<i class="fa-solid fa-location-dot mt-1" style="color: #6EE7B7;"></i>
						<span>R. Taquari - Campo Grande - MS</span>
					</div>
					<div class="d-flex align-items-center gap-2">
						<i class="fa-solid fa-envelope" style="color: #6EE7B7;"></i>
						<span>robotica.cg@ifms.edu.br</span>
					</div>
					<div class="d-flex align-items-center gap-2 mt-1">
						<i class="fa-solid fa-building-columns" style="color: #6EE7B7;"></i>
						<span>Campus Campo Grande</span>
					</div>
				</div>
			</div>
		</div>

		<!-- Barra de Direitos e Créditos -->
		<hr class="my-4 border-light opacity-20">

		<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 small" style="color: #A7F3D0;">
			<span>&copy; 2026 Portal Robótica IFMS Campus Campo Grande — Todos os direitos reservados.</span>
			<span>Desenvolvido na disciplina de Linguagem de Programação II</span>
		</div>
	</div>
</footer>

<!-- Scripts do Projeto (Bootstrap 5 & jQuery) -->
<script src="${pageContext.request.contextPath}/resources/jquery-3.6.0-dist/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap-5.1.3-dist/js/bootstrap.bundle.min.js"></script>
