class Application

  @@items = Item.all

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #   @@items.each do |item|
    #     resp.write "#{item}\n"
    #   end
    # elsif req.path.match(/search/)
    #
    #   search_term = req.params["q"]
    #
    #   if @@items.include?(search_term)
    #     resp.write "#{search_term} is one of our items"
    #   else
    #     resp.write "Couldn't find #{search_term}"
    #   end
    # if req.path.match(/items/)
    if req.path.match(/items/)
      item_search = req.path.split("/items/").last
      item = @@items.find { |i| i.name == item_search }
      if !!item
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end

end


# class Application
#
#   @@items = ["Apples","Carrots","Pears"]
#
#   def call(env)
#     resp = Rack::Response.new
#     req = Rack::Request.new(env)
#
#     if req.path.match(/items/)
#       @@items.each do |item|
#         resp.write "#{item}\n"
#       end
#     elsif req.path.match(/search/)
#
#       search_term = req.params["q"]
#
#       if @@items.include?(search_term)
#         resp.write "#{search_term} is one of our items"
#       else
#         resp.write "Couldn't find #{search_term}"
#       end
#
#     else
#       resp.write "Path Not Found"
#     end
#
#     resp.finish
#   end
# end
