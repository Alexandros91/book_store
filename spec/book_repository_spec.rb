require 'book_repository'

RSpec.describe BookRepository do

  def reset_books_table
    seed_sql = File.read('seeds/books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bookstore_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_table
  end

  it 'returns the list of books' do
    repo = BookRepository.new

    books = repo.all
    expect(books.length).to eq 2

    expect(books[0].id).to eq 1
    expect(books[0].title).to eq 'War and Peace'
    expect(books[0].author_name).to eq 'Leo Tolstoy'

    expect(books[1].id).to eq 2
    expect(books[1].title).to eq 'Pride and Prejudice'
    expect(books[1].author_name).to eq 'Jane Austen'
  end
end