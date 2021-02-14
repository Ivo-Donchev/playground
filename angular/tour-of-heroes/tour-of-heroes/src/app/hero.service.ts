import { Injectable } from '@angular/core';
import {Observable, of} from 'rxjs';
import { MessagesService } from './messages.service';
import { HEROES } from './mock-heroes';

@Injectable({
  providedIn: 'root'
})
export class HeroService {

  constructor(messagesService: MessagesService) {
    this.messagesService = messagesService;
  }
  
  getHeroes(): Observable<Hero[]> {
    this.messagesService.add('HeroService: fetched heroes.');

    return of(HEROES);
  }

  getHero(id: number): Observable<Hero> {
    this.messagesService.add(`HeroService: fetched hero id=${id}.`);

    return of(HEROES.find(hero => hero.id == id));
  }
}
