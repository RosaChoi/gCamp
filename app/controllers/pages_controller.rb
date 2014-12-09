class PagesController < ApplicationController
  def about

  end

  def terms

  end

  def faq
    @faqs = Faq.all
  end
end
