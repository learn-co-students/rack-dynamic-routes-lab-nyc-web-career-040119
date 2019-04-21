class Application

  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find{|item| item.name == item_name}

      if !item
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
