class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },   
    { id: 2, name: '和食' },
    { id: 3, name: '洋食・西洋料理' },
    { id: 4, name: '中華料理' },
    { id: 5, name: 'アジア・エスニック' },
    { id: 6, name: 'カレー' },
    { id: 7, name: '焼肉・ホルモン' },
    { id: 8, name: '鍋' },
    { id: 9, name: '居酒屋' },
    { id: 10, name: 'その他レストラン' },
    { id: 11, name: 'ラーメン・つけ麺' },
    { id: 12, name: 'カフェ・喫茶店' },
    { id: 13, name: 'スイーツ' },
    { id: 14, name: 'パン・サンドイッチ' },
    { id: 15, name: '料理旅館・オーベルジュ' },
    { id: 16, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts

end