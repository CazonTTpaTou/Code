# -*- coding: utf-8 -*-
import scrapy


class ShopcluesSpider(scrapy.Spider):
    name = 'shopclues'
    allowed_domains = ['www.reddit.com/r/gameofthrones/']
    start_urls = ['https://www.reddit.com/r/gameofthrones/']

 #location of csv file
    custom_settings = {'FEED_URI' : 'tmp/shopclues.csv'}
    custom_settings = {'ITEM_PIPELINES' : {'scrapy.pipelines.images.ImagesPipeline': 1}}
    custom_settings = {'IMAGES_STORE' : 'tmp/images/'}

    def parse(self, response):
    #Extract product information
       titles = response.css('.title.may-blank::text').extract()
       images = response.css('img::attr(fig-profile__media-photo)').extract()
       prices = response.css('.p_price::text').extract()
       discounts = response.css('.prd_discount::text').extract()

       for item in zip(titles,prices,images,discounts):
           scraped_info = {
               'title' : item[0],
               'price' : item[1],
               'image_urls' : [item[2]], #Set's the url for scrapy to download images
               'discount' : item[3]
           }

           yield scraped_info


