package com.dzm.payment.channel.paypal.service;

import com.dzm.payment.channel.paypal.config.PaypalPaymentIntent;
import com.dzm.payment.channel.paypal.config.PaypalPaymentMethod;
import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PaypalService {

	@Autowired
	private APIContext apiContext;

	@Value("${payment.paypal.default-cancel-url}")
	String defaultCancelUrl;

	@Value("${payment.paypal.default-success-url}")
	String defaultSuccessUrl;

	public Payment createPayment(
			int paymentPrice,
			String currency,
			PaypalPaymentMethod method,
			PaypalPaymentIntent intent,
			String description) throws PayPalRESTException{
		return createPayment(paymentPrice, currency, method, intent, description, defaultCancelUrl, defaultSuccessUrl);
	}
	
	public Payment createPayment(
			int paymentPrice,
			String currency, 
			PaypalPaymentMethod method, 
			PaypalPaymentIntent intent, 
			String description, 
			String cancelUrl, 
			String successUrl) throws PayPalRESTException{
		Amount amount = new Amount();
		amount.setCurrency(currency);
		amount.setTotal(String.format("%.2f", (double) paymentPrice / 100));

		Transaction transaction = new Transaction();
		transaction.setDescription(description);
		transaction.setAmount(amount);

		List<Transaction> transactions = new ArrayList<>();
		transactions.add(transaction);

		Payer payer = new Payer();
		payer.setPaymentMethod(method.toString());

		Payment payment = new Payment();
		payment.setIntent(intent.toString());
		payment.setPayer(payer);
		payment.setTransactions(transactions);
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl(cancelUrl);
		redirectUrls.setReturnUrl(successUrl);
		payment.setRedirectUrls(redirectUrls);

		return payment.create(apiContext);
	}
	
	public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
		Payment payment = new Payment();
		payment.setId(paymentId);
		PaymentExecution paymentExecute = new PaymentExecution();
		paymentExecute.setPayerId(payerId);
		return payment.execute(apiContext, paymentExecute);
	}

}
