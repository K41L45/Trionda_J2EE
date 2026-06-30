package com.trionda.servlet;

import com.trionda.facade.BookingFacade;
import com.trionda.model.Booking;
import com.trionda.model.Match;
import com.trionda.model.TicketCategory;
import com.trionda.service.MatchService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class BookingServlet extends BaseServlet {

    private final MatchService matchService = new MatchService();

    // GET → tampilkan halaman konfirmasi booking
    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            long categoryId = Long.parseLong(req.getParameter("categoryId"));
            long matchId    = Long.parseLong(req.getParameter("matchId"));

            Match match = matchService.findById(matchId);

            List<TicketCategory> categories =
                    matchService.findCategoriesByMatchId(matchId);

            // ✅ final copy untuk lambda
            final long finalCategoryId = categoryId;
            TicketCategory category = categories.stream()
                    .filter(c -> c.getCategoryId() == finalCategoryId)
                    .findFirst()
                    .orElse(null);

            if (category == null) {
                res.sendRedirect(req.getContextPath() + "/customer/matches");
                return;
            }

            req.setAttribute("category", category);
            req.setAttribute("match",    match);
            forward(req, res, "customer/booking_confirm.jsp");

        } catch (ServiceException | NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/customer/matches");
        }
    }

    // POST → proses booking
    @Override
    protected void processPost(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {

        Match match             = null;
        TicketCategory category = null;
        long matchId            = 0;

        try {
            // ✅ Parse sekali, langsung final — tidak pernah diubah lagi
            final long categoryId = Long.parseLong(req.getParameter("categoryId"));
            final int  quantity   = Integer.parseInt(req.getParameter("quantity"));

            // Ambil category + match SEBELUM booking
            category = matchService.findCategoryById(categoryId);
            matchId  = category.getMatchId();
            match    = matchService.findById(matchId);

            long userId = getSessionUserId(req);

            // Panggil Facade — Decorator + Observer + Strategy semua jalan di sini
            Booking booking = BookingFacade.createBooking(
                    userId, categoryId, quantity);

            // Set match ke request supaya booking_success.jsp bisa tampil bendera
            req.setAttribute("booking", booking);
            req.setAttribute("match",   match);
            forward(req, res, "customer/booking_success.jsp");

        } catch (ServiceException e) {
            // Error → forward balik ke confirm page dengan pesan error
            setError(req, e.getMessage());

            if (match != null && category != null) {
                // Re-fetch category untuk dapat quota terbaru
                try {
                    final long catId = category.getCategoryId();
                    final long mId   = matchId;

                    List<TicketCategory> cats =
                            matchService.findCategoriesByMatchId(mId);
                    TicketCategory freshCat = cats.stream()
                            .filter(c -> c.getCategoryId() == catId)
                            .findFirst()
                            .orElse(category);

                    req.setAttribute("match",    match);
                    req.setAttribute("category", freshCat);
                } catch (ServiceException ex) {
                    req.setAttribute("match",    match);
                    req.setAttribute("category", category);
                }
            }
            forward(req, res, "customer/booking_confirm.jsp");

        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/customer/matches");
        }
    }
}