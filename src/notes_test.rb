require 'codeclimate-test-reporter'
CodeClimate::TestReporter.configure do |config|
  config.path_prefix = "src" #the root of your Rails application relative to the repository root
  #config.git_dir = "https://github.com/sheyooo/andela-project.git" #the relative or absolute location of your git root compared to where your tests are run
  config.git_dir = ""
end

CodeClimate::TestReporter.start

require_relative 'notes'

RSpec.describe Sheyi::NotesApplication do
  it 'raises error if no name is supplied' do
    expect { Sheyi::NotesApplication.new '' }.to raise_error 'No name supplied!'
  end

  it 'raises error if invalid name is supplied' do
    expect { Sheyi::NotesApplication.new "\n\n\n\t" }.to raise_error 'No name supplied!'
  end

  it 'initialize the app with name' do
    expect(Sheyi::NotesApplication.new 'Tester').to be_instance_of Sheyi::NotesApplication
  end

  it "creation note content shouldn't be empty" do
    app = Sheyi::NotesApplication.new 'Tester'

    res = app.create('')
    expect(res).to eq nil
  end

  it 'creation note content should return note' do
    app = Sheyi::NotesApplication.new 'Tester'

    res = app.create('Andela')
    expect(res).to eq(author: 'Tester', content: 'Andela')
  end

  it 'create function should store in instance var' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('new note in var')

    expect(app.notes[0]).to eq(author: 'Tester', content: 'new note in var')
  end

  it 'create function should store in instance var more than one note' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('new note in var')
    app.create('another note in var')

    expect(app.notes[0]).to eq(author: 'Tester', content: 'new note in var')
    expect(app.notes[1]).to eq(author: 'Tester', content: 'another note in var')
    expect(app.notes.length).to eq 2
  end

  it 'edit function should edit appropriately' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('new note in var')
    app.edit(0, 'edited text')

    expect(app.notes[0]).to eq(author: 'Tester', content: 'edited text')
  end

  it 'the delete function should delete appropriately' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('a note')
    app.delete(0)

    expect(app.notes.length).to eq 0
  end

  it 'create function should store name in @author var' do
    app = Sheyi::NotesApplication.new 'Tester'

    expect(app.author).to eq 'Tester'
  end

  it 'the list function should return empty array if not populated' do
    app = Sheyi::NotesApplication.new 'Tester'
    res = app.list

    expect(res).to eq []
  end

  it 'the get function should return nil if not found' do
    app = Sheyi::NotesApplication.new 'Tester'
    res = app.get(0)

    expect(res).to eq nil
  end

  it 'the get function should return the string content of the note at an index' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('content1')
    app.create('content2')

    expect(app.get(0)).to eq 'content1'
    expect(app.get(1)).to eq 'content2'
  end

  it 'the list function should list all notes if populated' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('nice')
    app.create('another')
    res = app.list

    expect(res).to eq [{ author: 'Tester', content: 'nice' }, { author: 'Tester', content: 'another' }]
  end

  it 'the edit function should return nil if index not found' do
    app = Sheyi::NotesApplication.new 'Tester'
    res = app.edit(0, 'edit')

    expect(res).to eq nil
  end

  it 'the edit function should return nil if new content is empty' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('miya')
    res = app.edit(0, '')

    expect(res).to eq nil
  end

  it 'the edit function should return the new content if index is available and content is not empty' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('to be edited')
    res = app.edit(0, 'new content')

    expect(res).to eq 'new content'
    expect(app.get(0)).to eq 'new content'
  end

  it 'the delete function should always return nil' do
    app = Sheyi::NotesApplication.new 'Tester'

    expect(app.delete(0)).to eq nil
  end

  it 'search should return appropriately' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('Andela is a beautiful place')
    app.create('Welcome is a beautiful place')
    matches = app.search('Andela')

    expect(matches).to eq [0]
  end

  it 'search should be case insensitive' do
    app = Sheyi::NotesApplication.new 'Tester'
    app.create('Andela is a beautiful place')
    app.create('The andela fellowship')
    app.create('Welcome is a beautiful place')
    matches = app.search('ANDELA')

    expect(matches).to eq [0, 1]
  end
end
