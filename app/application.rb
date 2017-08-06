class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)

      item_name = req.path.split("/items/").last #turn /items/Figs into Figs

      if item = Item.all.find{|i| i.name == item_name} # find the item containing Figs
        resp.write item.price # print price of Figs
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400

      end

    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end

# INSTRUCTIONS
# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message