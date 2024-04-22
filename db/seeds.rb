users = [
  { name: 'João Silva', email: 'joao@example.com', password: 'password123' },
  { name: 'Maria Oliveira', email: 'maria@example.com', password: 'password456' },
  { name: 'Pedro Santos', email: 'pedro@example.com', password: 'password789' }
]

users.each do |u|
  User.create!(name: u[:name], email: u[:email], password: u[:password])
end

tags = [
  { name: 'Ruby' },
  { name: 'Rails' },
  { name: 'React' },
  { name: 'Vue' },
  { name: 'Docker' },
  { name: 'Machine Learning' },
  { name: 'AR' },
  { name: 'Devise' }
]

tags.each do |t|
  Tag.create!(name: t[:name])
end

posts = [
  {
    title: 'Minha Jornada no Aprendizado de Machine Learning',
    content: 'Recentemente, mergulhei fundo no mundo do Machine Learning e gostaria de compartilhar minha jornada e aprendizados com vocês. Uma das coisas que mais me impressionou foi a capacidade dos modelos de ML de aprender padrões complexos nos dados e fazer previsões precisas. No entanto, também descobri que a preparação dos dados é uma parte crucial do processo e pode consumir muito tempo.'
  },
  {
    title: 'Como Devise Simplificou a Autenticação em Meus Projetos',
    content: 'Sempre fui um grande fã do Devise quando se trata de autenticação em aplicativos Rails. Recentemente, tive a oportunidade de usar o Devise em um projeto e mais uma vez fiquei impressionado com o quão rápido e fácil é configurá-lo. Com apenas algumas linhas de código, consegui adicionar autenticação completa, incluindo registro, login e recuperação de senha.'
  },
  {
    title: 'Desafios e Descobertas: Minha Experiência com Realidade Aumentada',
    content: 'Recentemente, tive a oportunidade de trabalhar em um projeto de Realidade Aumentada (AR) e foi uma experiência incrível. Uma das coisas mais desafiadoras foi entender os conceitos fundamentais por trás da AR e como ela difere da Realidade Virtual. No entanto, uma vez que eu comecei a trabalhar com ferramentas como ARKit e Unity, fiquei impressionado com o quão poderosas são as possibilidades oferecidas pela AR.'
  },
  {
    title: 'Como o Docker Simplificou Minha Vida como Desenvolvedor',
    content: 'Recentemente, comecei a usar o Docker em meus projetos e fiquei impressionado com o quão fácil é configurar e gerenciar contêineres. Uma das coisas que mais me impressionou foi a capacidade de criar ambientes de desenvolvimento consistentes e isolados, o que me permitiu evitar problemas com dependências e configurações de ambiente. Além disso, descobri que o Docker é uma ferramenta poderosa para facilitar a implantação de aplicativos em produção.'
  }
]

posts.each do |p|
  post = Post.create!(title: p[:title], content: p[:content], user: User.all.sample)
  rand(1..6).times do
    post.tags << Tag.all.sample
  end
end

comments = [
  { message: 'Ótimo artigo! Obrigado por compartilhar sua experiência.', post: Post.first, user: User.all.sample },
  { message: 'Estou ansioso para experimentar o Devise em meu próximo projeto.', post: Post.second },
  { message: 'Realmente interessante! Você poderia compartilhar mais detalhes sobre o projeto de AR?',
    post: Post.third, user: User.all.sample },
  { message: 'Docker é incrível! Eu uso em todos os meus projetos agora.', post: Post.fourth },
  { message: 'Excelente post! Obrigado por compartilhar.', post: Post.first, user: User.all.sample }
]

comments.each do |c|
  rand(1..3).times do
    Comment.create!(message: c[:message], post: c[:post], user: User.all.sample)
  end
end
