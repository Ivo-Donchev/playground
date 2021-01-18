import { Component, OnInit } from '@angular/core';
import { Hero } from '../hero';
import { HeroService } from '../hero.service';
import { MessagesService } from '../messages.service';
import { HEROES } from '../mock-heroes';

@Component({
  selector: 'app-heroes',
  templateUrl: './heroes.component.html',
  styleUrls: ['./heroes.component.css']
})
export class HeroesComponent implements OnInit {
  selectedHero: Hero;

  heroes: Hero[];

  onSelect(hero: Hero): void {
    this.selectedHero = hero;
    this.messagesService.add(`HeroesComponent: Select hero id=${hero.id}`)
  }
  
  getHeroes(): void {
    this.heroService.getHeroes().subscribe(
      heroes => this.heroes = heroes
    )
  }

  constructor(private heroService: HeroService, private messagesService: MessagesService) {}
  
  ngOnInit(): void {
    this.getHeroes()
  }

}
