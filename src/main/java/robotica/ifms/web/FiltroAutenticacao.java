package robotica.ifms.web;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/gestao.jsp")
public class FiltroAutenticacao implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Verifica se existe a sessão com o coordenador logado
        boolean isLoggedIn = (session != null && session.getAttribute("coordenadorLogado") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response); // Permite o acesso à página protegida
        } else {
            // Se não estiver logado, redireciona para a tela de login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}