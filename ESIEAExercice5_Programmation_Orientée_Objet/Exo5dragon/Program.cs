using System;

public enum ChanceCard
{
    Sort,
    Fuite,
    Portauloin
}

public class Character
{
    protected string name;
    protected int position;

    public Character(string name, int position)
    {
        this.name = name;
        Position = position;
    }

    public string Name { get { return name; } }
    public virtual int Position
    {
        get { return position; }
        set { position = value; }
    }

    public virtual void Move(int diceRoll)
    {
        position += diceRoll;
        if (position > 31)
            position = 31;
        if (position < 0)
            position = 0;
    }
}

public class Elf : Character
{
    private int attemptsLeft;

    public Elf(string name, int position, int attempts)
        : base(name, position)
    {
        attemptsLeft = attempts;
    }

    public int AttemptsLeft { get { return attemptsLeft; } }

    public override void Move(int diceRoll)
    {
        base.Move(diceRoll);
        if (position == 0)
            attemptsLeft--;
        Console.WriteLine($"L'elfe avance jusqu'à la case {Position}.");
    }
}

public class Dragon : Character
{
    private Random random;

    public Dragon(string name, int position)
        : base(name, position)
    {
        random = new Random();
    }

    public void Attack()
    {
        int diceRoll = random.Next(1, 7);
        if (diceRoll <= 3)
        {
            Console.WriteLine("Le dragon crache du feu !");
            position -= 2;
        }
        else
        {
            Console.WriteLine("Le dragon ne parvient pas à cracher du feu.");
        }
    }

    public override void Move(int diceRoll)
    {
        base.Move(diceRoll);
        Console.WriteLine($"Le dragon avance jusqu'à la case {Position}.");
    }
}

public class Game
{
    private Elf elf;
    private Dragon dragon;
    private Random random;

    public Game(string elfName, int elfAttempts, string dragonName)
    {
        elf = new Elf(elfName, 0, elfAttempts);
        dragon = new Dragon(dragonName, 30);
        random = new Random();
    }

    public void Play()
    {
        while (elf.Position < 31 && elf.AttemptsLeft > 0)
        {
            ElfTurn();
            if (elf.Position >= 31 || elf.AttemptsLeft <= 0)
                break;

            DragonTurn(GetElf());
        }

        if (elf.Position == 31)
            Console.WriteLine($"Félicitations ! {elf.Name} a atteint le trésor !");
        else
            Console.WriteLine($"Partie terminée ! {elf.Name} a épuisé toutes ses tentatives.");
    }

    private void ElfTurn()
    {
        int elfDiceRoll = random.Next(1, 7);
        elf.Move(elfDiceRoll);

        if (elf.Position == dragon.Position)
        {
            Console.WriteLine("L'elfe et le dragon sont sur la même case !");
            ChanceCard card = (ChanceCard)random.Next(0, Enum.GetNames(typeof(ChanceCard)).Length);
            HandleChanceCard(card);
        }
    }

    private Elf GetElf()
    {
        return elf;
    }

    private void DragonTurn(Elf elf)
    {
        int dragonDiceRoll = random.Next(1, 7);
        dragon.Move(-dragonDiceRoll);

        if (elf.Position == dragon.Position)
        {
            Console.WriteLine("L'elfe et le dragon sont sur la même case !");
            dragon.Attack();
            if (elf.Position < 0)
                elf.Position = 0;
        }
    }

    private void HandleChanceCard(ChanceCard card)
    {
        switch (card)
        {
            case ChanceCard.Sort:
                Console.WriteLine("L'elfe tire une carte Sort !");
                Console.WriteLine("Le dragon recule de 3 case !");
                dragon.Move(3);
                break;
            case ChanceCard.Fuite:
                Console.WriteLine("L'elfe tire une carte Fuite !");
                Console.WriteLine("L'elfe recule de 1 case !");
                elf.Move(-1);
                break;
            case ChanceCard.Portauloin:
                Console.WriteLine("L'elfe tire une carte Portauloin !");
                Console.WriteLine("L'elfe se téléporte de 3 case !");
                elf.Move(3);
                break;
            default:
                break;
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Bienvenue dans Le Trésor du Dragon !");
        Console.Write("Entrez le nom de l'elfe : ");
        string elfName = Console.ReadLine();

        int elfAttempts;
        do
        {
            Console.Write("Entrez le nombre de tentatives de l'elfe : ");
        } while (!int.TryParse(Console.ReadLine(), out elfAttempts) || elfAttempts <= 0);

        Console.Write("Entrez le nom du dragon : ");
        string dragonName = Console.ReadLine();

        Game game = new Game(elfName, elfAttempts, dragonName);
        game.Play();
    }
}
