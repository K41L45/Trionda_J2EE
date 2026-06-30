package com.trionda.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * TEMPLATE METHOD PATTERN
 *
 * BaseServlet mendefinisikan SKELETON algoritma request handling:
 *   1. Set karakter encoding
 *   2. Panggil processGet() atau processPost() — diisi subclass
 *   3. Handle error terpusat jika ada exception
 *
 * Kenapa Template Method di sini?
 * Setiap servlet punya alur yang sama persis:
 *   terima request → proses → forward ke JSP
 * Daripada tiap servlet tulis ulang boilerplate yang sama,
 * BaseServlet menulis sekali, subclass hanya isi bagian uniknya.
 *
 * Subclass WAJIB override processGet() dan/atau processPost().
 * Subclass TIDAK BOLEH override doGet()/doPost() langsung.
 */
public abstract class BaseServlet extends HttpServlet {

    // TEMPLATE METHOD — skeleton yang tidak boleh diubah subclass
    @Override
    protected final void doGet(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");      // ← step 1: encoding
        res.setCharacterEncoding("UTF-8");
        processGet(req, res);                   // ← step 2: subclass isi ini
    }

    @Override
    protected final void doPost(HttpServletRequest req,
                                HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");      // ← step 1: encoding
        res.setCharacterEncoding("UTF-8");
        processPost(req, res);                  // ← step 2: subclass isi ini
    }

    // HOOK METHODS — subclass override sesuai kebutuhan
    // Default: 405 Method Not Allowed
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    protected void processPost(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {
        res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    // -------------------------------------------------------
    // HELPER METHODS — utility yang bisa dipakai semua subclass
    // -------------------------------------------------------

    /** Forward ke JSP di dalam WEB-INF/views/ */
    protected void forward(HttpServletRequest req,
                           HttpServletResponse res,
                           String viewPath)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/" + viewPath)
                .forward(req, res);
    }

    /** Ambil session user yang sedang login, null jika belum login */
    protected HttpSession getSession(HttpServletRequest req) {
        return req.getSession(false);
    }

    /** Ambil user_id dari session */
    protected long getSessionUserId(HttpServletRequest req) {
        HttpSession session = getSession(req);
        if (session == null) return -1;
        Object id = session.getAttribute("user_id");
        return id != null ? (long) id : -1;
    }

    /** Ambil role dari session */
    protected String getSessionRole(HttpServletRequest req) {
        HttpSession session = getSession(req);
        if (session == null) return null;
        return (String) session.getAttribute("role");
    }

    /** Taruh pesan error ke request attribute */
    protected void setError(HttpServletRequest req, String message) {
        req.setAttribute("errorMessage", message);
    }

    /** Taruh pesan sukses ke request attribute */
    protected void setSuccess(HttpServletRequest req, String message) {
        req.setAttribute("successMessage", message);
    }
}