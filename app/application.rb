require 'pry'

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
    if req.path.match(/items/)

      item_name = req.path.split("/items/").last # turn /items/item_name into an item_name page
      item = @@items.find{|i| i.name == item_name} # if it matches something that exists in our @@items, then we can output the below

      # IF a user requests an item that you don't have, then return a 400 and an error message
      if item.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        # If a user requests /items/<Item Name> it should return the price of that item
        resp.write item.price
      end

    else

      resp.write "Route not found"
      resp.status = 404

    end

    resp.finish
  end
end
