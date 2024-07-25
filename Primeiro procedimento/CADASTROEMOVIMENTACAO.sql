CREATE SEQUENCE PESSOASEQ
AS INT
START WITH 1
INCREMENT BY 1;

CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    NomeUsuario NVARCHAR(50) NOT NULL,
    Senha NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL
);

CREATE TABLE Pessoas (
    PessoaID INT PRIMARY KEY DEFAULT NEXT VALUE FOR PessoaSeq,
    TipoPessoa NVARCHAR(10) CHECK (TipoPessoa IN ('Física', 'Jurídica')) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Endereco NVARCHAR(200),
    Telefone NVARCHAR(20),
    Email NVARCHAR(100),
    CPF CHAR(11) NULL,
    CNPJ CHAR(14) NULL
);

CREATE TABLE Produtos (
    ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
    NomeProduto NVARCHAR(100) NOT NULL,
    Quantidade INT NOT NULL,
    PrecoVenda DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Compras (
    CompraID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    PessoaID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10, 2) NOT NULL,
    DataCompra DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

CREATE TABLE Vendas (
    VendaID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    PessoaID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10, 2) NOT NULL,
    DataVenda DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

CREATE LOGIN loja WITH PASSWORD = 'loja';

CREATE USER loja FOR LOGIN loja;

ALTER ROLE db_owner ADD MEMBER loja;