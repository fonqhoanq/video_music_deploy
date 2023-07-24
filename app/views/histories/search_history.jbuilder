json.array! @history_searchs do |history_search|
  json.id history_search.id
  json.text history_search.search_text
end
